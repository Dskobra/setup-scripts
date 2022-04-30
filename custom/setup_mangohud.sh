#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
cd data
cp *.conf /home/$USER/.config/MangoHud/