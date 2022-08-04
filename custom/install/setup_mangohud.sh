#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
cd install/data/mangohud
cp *.conf /home/$USER/.config/MangoHud/