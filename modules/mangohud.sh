#!/usr/bin/bash
SCRIPTS_HOME=$(pwd)
cd $SCRIPTS_HOME/modules/
git clone https://github.com/Dskobra/setup-scripts -b mangohud

mv setup-scripts mango_conf
cd mango_conf
dos2unix *.conf
sudo chown $USER:$USER *.conf
cp *.conf $HOME/.config/MangoHud/
#cp wine-GTA5.conf $HOME/.config/MangoHud/
#cp wine-NewWorld.conf $HOME/.config/MangoHud/
#cp wine-PathOfExile_x64Steam.conf $HOME/.config/MangoHud/
#cp wine-R5Apex.conf $HOME/.config/MangoHud/
#cp wine-RuneScape.conf $HOME/.config/MangoHud/
#cp wine-WorldOfTanks.conf $HOME/.config/MangoHud/
#cp wine-WorldOfWarships.conf $HOME/.config/MangoHud/
#cp wine-Gw2-64.conf $HOME/.config/MangoHud/
#cp wine-WoW.conf $HOME/.config/MangoHud/
#cp "wine-Diablo IV.conf" $HOME/.config/MangoHud/