#!/bin/bash

source CONFIG

cd host-scripts

# Store completed steps
mkdir ../steps

# Steps whitelist
rm ../steps/{1,2,3,4,5,114}

# Run every script in /host-scripts
for i in $(seq 1 $(cat ../COUNT)); 
do 
    clear

    if [ -f "../steps/$i" ]; then
        echo "Step $i already completed"
    else 
        echo "###### STEP $i ######"

        # Run the step
        ./${i}-*.sh

        # Check if error
        RET_CODE=$?
        if [ $RET_CODE -ne 0 ]; then
            echo "STOPPED: ERROR IN STEP $i"
            exit 1
        fi

        touch ../steps/${i}

        # SUCCESS
        echo "###### STEP $i ######"
    fi

done

