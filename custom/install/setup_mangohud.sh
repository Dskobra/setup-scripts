#! /usr/bin/bash

USER=$(whoami)
mkdir /home/$USER/.config/MangoHud/
mkdir /home/$USER/.var/app/net.lutris.Lutris/config/MangoHud/
mkdir /home/$USER/.var/app/com.usebottles.bottles/config/MangoHud/
cd install/data/mangohud

# for steam/lutris installed via package manager
cp wine-GTA5.conf /home/$USER/.config/MangoHud/
cp wine-NewWorld.conf /home/$USER/.config/MangoHud/
cp wine-PathOfExile_x64Steam.conf /home/$USER/.config/MangoHud/
cp wine-R5Apex.conf /home/$USER/.config/MangoHud/
cp wine-RuneScape.conf /home/$USER/.config/MangoHud/
cp wine-WorldOfTanks.conf /home/$USER/.config/MangoHud/
cp wine-WorldOfWarships.conf /home/$USER/.config/MangoHud/
cp wine-Gw2-64.conf /home/$USER/.config/MangoHud/
cp wine-WoW.conf /home/$USER/.config/MangoHud/

# for flutris/flatpak installed via flatpak
#cp wine-Gw2-64.conf /home/$USER/.var/app/net.lutris.Lutris/config/MangoHud/
#cp wine-WoW.conf /home/$USER/.var/app/com.usebottles.bottles/config/MangoHud/