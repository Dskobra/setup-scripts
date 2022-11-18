#!/usr/bin/bash

USER=$(whoami)


mkdir /home/$USER/.config/MangoHud/
#lutris/bottles store MangoHud under /home/$USER/.var/app/APPNAME/config/MangoHud/
ln -s "/home/$USER/.config/MangoHud/" "/home/$USER/.var/app/net.lutris.Lutris/config/"
ln -s "/home/$USER/.config/MangoHud/" "/home/$USER/.var/app/com.usebottles.bottles/config/"

cd conf
sudo chown $USER:$USER *.conf
cp wine-GTA5.conf /home/$USER/.config/MangoHud/
cp wine-NewWorld.conf /home/$USER/.config/MangoHud/
cp wine-PathOfExile_x64Steam.conf /home/$USER/.config/MangoHud/
cp wine-R5Apex.conf /home/$USER/.config/MangoHud/
cp wine-RuneScape.conf /home/$USER/.config/MangoHud/
cp wine-WorldOfTanks.conf /home/$USER/.config/MangoHud/
cp wine-WorldOfWarships.conf /home/$USER/.config/MangoHud/
cp wine-Gw2-64.conf /home/$USER/.config/MangoHud/
cp wine-WoW.conf /home/$USER/.config/MangoHud/
