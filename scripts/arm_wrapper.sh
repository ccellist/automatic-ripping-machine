#!/bin/bash

DEVNAME=$1

log () {
  is_docker=`cat /proc/1/cgroup | grep docker | wc -l`
  if [[ is_docker -gt 0 ]]; then
     # We're running docker, can't use logger.
     # Just print to sysout.
     echo $1
  else
     echo $1 | logger -t ARM -s
  fi
}

sleep 5 # allow the system enough time to load disc information such as title

log "[ARM] Starting ARM on ${DEVNAME}"
/bin/su -l -c "/usr/bin/python3 /opt/arm/arm/ripper/main.py -d ${DEVNAME}" -s /bin/bash arm

# Check to see if the admin page is running, if not, start it
if pgrep -f "runui.py" > /dev/null
then
        log "[ARM] ARM Webgui running." 
else
        log "[ARM] ARM Webgui not running; starting it " 
        /bin/su -l -c "/usr/bin/python3 /opt/arm/arm/runui.py  " -s /bin/bash arm
        # Try the below line if you want it to log to your log file of choice
        #/bin/su -l -c "/usr/bin/python3 /opt/arm/arm/runui.py  &> [pathtologDir]/WebUI.log" -s /bin/bash arm
fi
