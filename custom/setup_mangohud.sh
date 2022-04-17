#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
cd mangohud 
cp *.conf /home/$USER/.config/MangoHud/