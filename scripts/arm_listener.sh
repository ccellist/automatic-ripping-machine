#!/bin/bash
while (true); do
    sleep 5
    echo "Running script against /dev/sr0..."
    /bin/bash -c "/opt/arm/scripts/arm_wrapper.sh /dev/sr0"
    echo "Done, looping again."
done
