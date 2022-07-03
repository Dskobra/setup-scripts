#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
cd install/data/steam
cp *.conf /home/$USER/.var/app/com.valvesoftware.Steam/config/MangoHud