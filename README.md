# lfs-auto

This is an automated Linux From Scratch build based on the LFS 11.2 systemd book. The system is built in a directory instead of mounted partitions and can then be built into an EFI & BIOS bootable ISO with persistent storage. All steps follow the order of the book except for the Grub section (step 118), which is omitted since the grub bootloader is installed when calling the ```persistent-usb.sh``` script.

**Note: This has only been tested on Debian based distros with X86_64 arch.**

## Instructions

1. Edit the ```CONFIG``` file params.
2. Edit the ```lfs-scripts/117.sh``` script which is executed once the LFS system is built to perform a final custom configuration (it is executed inside the LFS system with chroot).
3. Edit the ```resources/linux-config``` file if you want to modify a build parameter of the Linux kernel.
4. Build the system (must not be executed as root, some steps require sudo auth tho):

```bash
cd lfs-auto/
./build.sh
```

5. Create a BIOS/UEFI bootable USB stick with persistent storage (once created it will ask you to set the root user password):

```bash
./persistent-usb.sh /dev/sdX
```

For every completed step, a file named with the step number is created under the lfs-auto/completed-steps dir. Removing one of those files makes the ```build.sh``` script re-run that step. You can also add the step number in the whitelist array inside ```build.sh``` to re-run it every time ```build.sh``` is executed.

**Note: Do not run any script located inside lfs-auto/lfs-scripts or lfs-auto/host-scripts directly. Always call the ./build.sh script instead, since some steps require the execution of previous steps.**
