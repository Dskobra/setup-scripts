#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
cd install/data/nonsteam
cp *.conf /home/$USER/.config/MangoHud/