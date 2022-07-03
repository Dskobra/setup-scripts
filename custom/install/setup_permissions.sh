#!/usr/bin/bash

cd install/data
sudo chown $USER:$USER *.sh

cd nonsteam
sudo chown $USER:$USER *.conf

cd ../shortcuts
sudo chown $USER:$USER *.desktop

cd ../steam
sudo chown $USER:$USER *.conf