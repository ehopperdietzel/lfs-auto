#!/bin/bash

# MUST BE EXECUTED FROM THE SAME DIR (./build)

source CONFIG

cd host-scripts

# Store completed steps
[ ! -d ../completed-steps] && mkdir ../completed-steps

# Steps whitelist (are executed every time this script runs)
rm ../completed-steps/{1,2,3,4,5,29,30,114}

# Run every script in /host-scripts
for i in $(seq 1 117); 
do 
    clear

    if [ -f "../completed-steps/$i" ]; then
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

        touch ../completed-steps/${i}

        # SUCCESS
        echo "###### STEP $i ######"
    fi

done