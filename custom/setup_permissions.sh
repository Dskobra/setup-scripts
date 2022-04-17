#!/usr/bin/bash

cd /launchers/
sudo chown $USER:$USER *.sh
cd ../shortcuts
sudo chown $USER:$USER *.desktop
cd ../mangohud
sudo chown $USER:USER -R *.conf