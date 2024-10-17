#!/usr/bin/bash

### Main launch script which makes the temp/app folders
### and sets some variables

make_temp(){
    test -d "$SCRIPTS_FOLDER"/temp && TEMP_FOLDER="exists"
    if [ "$TEMP_FOLDER" = "exists" ];
        then
           TEMP_FOLDER="exists"
    elif [ "$TEMP_FOLDER" = "missing" ];
        then
        mkdir "$SCRIPTS_FOLDER"/temp            # make a temp folder for all files to be downloaded to
    fi
}

make_app_folder(){
### Store netbeans, intellij idea and pycharm
### in ~/Apps
    test -d "$HOME"/Apps && LOOK_FOR_APP_FOLDER="exists"
    if [ "$LOOK_FOR_APP_FOLDER" = "exists" ];
        then
           LOOK_FOR_APP_FOLDER="exists"
    elif [ "$LOOK_FOR_APP_FOLDER" = "missing" ];
        then
            mkdir "$APP_FOLDER"
    fi
}

export SCRIPTS_FOLDER                           # stores full path for setup-scripts
export APP_FOLDER="$HOME/Apps"                  # app folder thats made for some downloads
export PKGMGR=""                                # stores package manager name such as dnf/rpm-ostree etc
export COPYRIGHT="Copyright (c) 2021-2024 Jordan Bottoms"
export VERSION="10.17.2024"
export PACKAGE_TYPE="flatpak"
TEMP_FOLDER="missing"
LOOK_FOR_APP_FOLDER="missing"
SCRIPTS_FOLDER=$(pwd)
make_temp
make_app_folder
"$SCRIPTS_FOLDER"/modules/core/distro_check.sh