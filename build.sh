#!/bin/bash

source CONFIG

# Run every step starting with the number inside the STEP file
for i in $(seq 1 9); 
do 
    clear
    echo "###### STEP $i ######"; 

    # Save current step
    echo $i > ./STEP

    # Run the step
    ./${i}*.sh

    # Check if error
    RET_CODE=$?
    if [ $RET_CODE -ne 0 ]; then
        echo "STOPPED: ERROR IN STEP $i"
        exit 1
    fi

    # SUCCESS
    echo "###### STEP $i ######"
done

