#!/bin/bash

source CONFIG

cd host-scripts

# Run every script in /host-scripts
for i in $(seq 1 18); 
do 
    clear

    echo "###### STEP $i ######"; 

    # Run the step
    ./${i}-*.sh

    # Check if error
    RET_CODE=$?
    if [ $RET_CODE -ne 0 ]; then
        echo "STOPPED: ERROR IN STEP $i"
        exit 1
    fi

    # SUCCESS
    echo "###### STEP $i ######"
done

