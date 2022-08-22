#!/usr/bin/bash

cd install/data
sudo chown $USER:$USER *.sh

cd mangohud
sudo chown $USER:$USER *.conf

cd ../shortcuts
sudo chown $USER:$USER *.desktop