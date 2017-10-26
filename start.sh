#!/bin/bash
# add for NodeJS debugging -> -p 5858:5858

sudo docker run -d -v /home/pi/steward-docker/db:/usr/src/app/db -p 8887:8887 -p 8888:8888 --name steward --device /dev/ttyUSB0 -v /run/udev:/run/udev:ro siburny/steward
