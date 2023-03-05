#define _GNU_SOURCE

#include <sys/mount.h>
#include <unistd.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <blkid/blkid.h>
#include <string.h>
#include <dirent.h> 
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/vfs.h>

#define DOT_OR_DOTDOT(s) ((s)[0] == '.' && (!(s)[1] || ((s)[1] == '.' && !(s)[2])))

// Make up for header deficiencies
#ifndef RAMFS_MAGIC
# define RAMFS_MAGIC ((unsigned)0x858458f6)
#endif
#ifndef TMPFS_MAGIC
# define TMPFS_MAGIC ((unsigned)0x01021994)
#endif
#ifndef MS_MOVE
# define MS_MOVE     8192
#endif

int
libiberty_vprintf_buffer_size (const char *format, va_list args)
{
  const char *p = format;
  /* Add one to make sure that it is never zero, which might cause malloc
     to return NULL.  */
  int total_width = strlen (format) + 1;
  va_list ap;
#ifdef va_copy
  va_copy (ap, args);
#else
  memcpy ((void *) &ap, (void *) &args, sizeof (va_list));
#endif
  while (*p != '\0')
    {
      if (*p++ == '%')
        {
          while (strchr ("-+ #0", *p))
            ++p;
          if (*p == '*')
            {
              ++p;
              total_width += abs (va_arg (ap, int));
            }
          else
            total_width += strtoul (p, (char **) &p, 10);
          if (*p == '.')
            {
              ++p;
              if (*p == '*')
                {
                  ++p;
                  total_width += abs (va_arg (ap, int));
                }
              else
              total_width += strtoul (p, (char **) &p, 10);
            }
          while (strchr ("hlL", *p))
            ++p;
          /* Should be big enough for any format specifier except %s and floats.  */
          total_width += 30;
          switch (*p)
            {
            case 'd':
            case 'i':
            case 'o':
            case 'u':
            case 'x':
            case 'X':
            case 'c':
              (void) va_arg (ap, int);
              break;
            case 'f':
            case 'e':
            case 'E':
            case 'g':
            case 'G':
              (void) va_arg (ap, double);
              /* Since an ieee double can have an exponent of 307, we'll
                 make the buffer wide enough to cover the gross case. */
              total_width += 307;
              break;
            case 's':
              total_width += strlen (va_arg (ap, char *));
              break;
            case 'p':
            case 'n':
              (void) va_arg (ap, char *);
              break;
            }
          p++;
        }
    }
#ifdef va_copy
  va_end (ap);
#endif
  return total_width;
}

char *
xvasprintf (const char *format,
#if defined (_BSD_VA_LIST_) && defined (__FreeBSD__)
           _BSD_VA_LIST_ args)
#else
           va_list args)
#endif
{
  char *result;
  int total_width = libiberty_vprintf_buffer_size (format, args);
  result = (char *) malloc (total_width);
  vsprintf (result, format, args);
  return result;
}

char *
xasprintf (const char *fmt, ...)
{
  char *buf;
  va_list ap;
  va_start (ap, fmt);
  buf = xvasprintf (fmt, ap);
  va_end (ap);
  return buf;
}

char* last_char_is(const char *s, int c)
{
	if (s && *s) {
		size_t sz = strlen(s) - 1;
		s += sz;
		if ( (unsigned char)*s == c)
			return (char*)s;
	}
	return NULL;
}

char* concat_path_file(const char *path, const char *filename)
{
	char *lc;
	if (!path)
		path = "";
	lc = last_char_is(path, '/');
	while (*filename == '/')
		filename++;
	return xasprintf("%s%s%s", path, (lc==NULL ? "/" : ""), filename);
}

// Recursively delete contents of rootfs
static void delete_contents(const char *directory, dev_t rootdev)
{
	DIR *dir;
	struct dirent *d;
	struct stat st;

	// Don't descend into other filesystems
	if(lstat(directory, &st) || st.st_dev != rootdev)
		return;

	// Recursively delete the contents of directories
	if (S_ISDIR(st.st_mode)) {
		dir = opendir(directory);
		if (dir) {
			while ((d = readdir(dir))) {
				char *newdir = d->d_name;

				// Skip . and ..
				if (DOT_OR_DOTDOT(newdir))
					continue;

				// Recurse to delete contents
				newdir = concat_path_file(directory, newdir);
				delete_contents(newdir, rootdev);
				free(newdir);
			}
			closedir(dir);

			// Directory should now be empty, zap it
			rmdir(directory);
		}
	} else {
		// It wasn't a directory, zap it
		unlink(directory);
	}
}

void switch_root()
{
	struct stat st;
	struct statfs stfs;
	dev_t rootdev;

	// Change to new root directory and verify it's a different fs
	chdir("/root");
	lstat("/", &st);
	rootdev = st.st_dev;
	lstat(".", &st);

	if(st.st_dev == rootdev || getpid() != 1) 
    {
		printf("Error: /root must be a mount point.");
        return;
	}

	statfs("/", &stfs); // this never fails
	if((unsigned)stfs.f_type != RAMFS_MAGIC && (unsigned)stfs.f_type != TMPFS_MAGIC) 
    {
		printf("Error: root filesystem is not ramfs/tmpfs.");
        return;
	}

	// Zap everything out of rootdev
	delete_contents("/", rootdev);

	// Overmount / with newdir and chroot into it
	if(mount(".", "/", NULL, MS_MOVE, NULL)) 
    {
		// For example, fails when newroot is not a mountpoint
		printf("Error moving root.");
        return;
	}

	chroot(".");

	// Exec real init
	execl("/sbin/init", "init", NULL);
}

int main(int argc, char **argv)
{

    // Mount some required fs so that blkid can find the "LFS-ROOT" partition
    
    mkdir("/proc", 0700);
    mkdir("/dev", 0700);
    mkdir("/sys", 0700);

    if (mount("none", "/proc", "proc", 0, "") == -1) 
    {
        printf("Error: could not mount /proc.");
        return 1;
    }

    if (mount("none", "/dev", "devtmpfs", 0, "") == -1) 
    {
        printf("Error: could not mount /devtmpfs.");
        return 1;
    }

    if (mount("none", "/sys", "sysfs", 0, "") == -1) 
    {
        printf("Error: could not mount /sysfs.");
        return 1;
    }

    // Search LFS-ROOT partition

    int res;

    blkid_cache cache;
    blkid_dev_iterate it;
    blkid_dev dev;

    const char *name = NULL;
    const char *tag_value = NULL;

    res = blkid_get_cache(&cache, NULL);
    blkid_probe_all(cache);
    
    it = blkid_dev_iterate_begin(cache);
    res = 0;

    while (1)
    {
        res = blkid_dev_next(it, &dev);

        if (res != 0)
        {
            printf("Error: LFS partition not found.\n");
            return 1;
        }

        name = blkid_dev_devname(dev);

        tag_value = blkid_get_tag_value(cache, "LABEL", name);

        if(tag_value && strcmp(tag_value, "LFS-ROOT") == 0)
        {
            // LFS partition found!
            mkdir("/root", 0700);

            // Mount "LFS-ROOT" partition
            mount(name, "/root", "ext4", 0, "");

            // Switch root and start systemd
            switch_root();
            return 0;
        }
    }

    return 1;
}

