#!/usr/bin/bash
ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
cd $SCRIPTS_HOME/modules/
git clone https://github.com/Dskobra/setup-scripts -b game_profiles

mv setup-scripts game_profiles
cd game_profiles
dos2unix *.conf
sudo chown $USER:$USER *.conf
cp *.conf $HOME/.config/MangoHud/