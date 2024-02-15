#! /usr/bin/bash

### minecraft launch script
### launch minecraft and separate the process 
### keeping it open without this script

cd /home/$USER/.AppInstalls/
# run minecraft while supressing input/output to avoid a logfile being made
nohup ./minecraft-launcher 0</dev/null 1>/dev/null 2>/dev/null &
