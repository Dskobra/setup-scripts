#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
cd mangohud 
sudo chown $USER:USER -R *.conf
mv *.conf /home/$USER/.config/MangoHud/