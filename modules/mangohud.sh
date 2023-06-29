#!/usr/bin/bash

cd $SCRIPTS_HOME/modules/
git clone https://github.com/Dskobra/setup-scripts -b mangohud

mv setup-scripts mango_conf
cd mango_conf
dos2unix *.conf
sudo chown $USER:$USER *.conf
cp *.conf $HOME/.config/MangoHud/