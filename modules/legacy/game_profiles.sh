#!/usr/bin/bash
ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"

if test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
    echo "MangoHud.conf exists. Not copying profiles over."
elif ! test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
    cd $SCRIPTS_HOME/temp/
    git clone https://github.com/Dskobra/setup-scripts -b game-profiles

    mv setup-scripts game-profiles
    cd game-profiles
    dos2unix *.conf
    sudo chown $USER:$USER *.conf
    cp *.conf $HOME/.config/MangoHud/
fi
