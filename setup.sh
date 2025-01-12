#!/usr/bin/bash

### Main launch script which makes the temp/app folders
### and sets some variables

export SCRIPTS_FOLDER                           # stores full path for setup-scripts
export APP_FOLDER="$HOME/Apps"                  # app folder thats made for some downloads
export DISTRO=""                                # stores distro name.
export COPYRIGHT="Copyright (c) 2021-2025 Jordan Bottoms"
export VERSION="1.5.2025"
SCRIPTS_FOLDER=$(pwd)
mkdir $SCRIPTS_FOLDER/temp
mkdir /home/$USER/Apps/                         # old location. Remove once everything is updated
mkdir /home/$USER/bin
sudo mkdir /opt/apps/
sudo mkdir /opt/apps/icons
sudo mkdir /opt/apps/appimages
sudo chown $USER:$USER /opt/apps/ -R
"$SCRIPTS_FOLDER"/modules/core/launcher.sh