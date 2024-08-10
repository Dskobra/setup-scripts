#!/usr/bin/bash

### Main launch script which includes menus, distro
### determination and making app/temp folders.

run_prereq_check(){
    ### make sure git, curl, wget, zenity
    ### and flatpak are installed.
    RAN_ONCE_FILE=$SCRIPTS_FOLDER/.ranonce.txt
    test -f $RAN_ONCE_FILE && RAN_ONCE_FILE="exists"
    if [ "$RAN_ONCE_FILE" = "exists" ]
    then
        echo "Skipping first run steps."
    else
        #source $SCRIPTS_FOLDER/packages.sh; "install_prereq"
        $SCRIPTS_FOLDER/modules/core/prereq.sh
        touch $SCRIPTS_FOLDER/.ranonce.txt
        zenity --info --text="Required packages now installed and enabled 3rd party repositories. May now proceed to text menu."
    fi
}

make_temp(){
    test -d $SCRIPTS_FOLDER/temp && TEMP_FOLDER=exists
    if [ "$TEMP_FOLDER" = "exists" ];
        then
           TEMP_FOLDER=exists 
    elif [ "$TEMP_FOLDER" = "missing" ];
        then
        mkdir $SCRIPTS_FOLDER/temp        # make a temp folder for all files to be downloaded to   
    fi
}

make_app_folder(){
    ### Store netbeans, intellij idea and pycharm
    ### in ~/Apps  
    test -d $HOME/Apps && LOOK_FOR_APP_FOLDER=exists
    if [ "$LOOK_FOR_APP_FOLDER" = "exists" ];
        then
           LOOK_FOR_APP_FOLDER=exists 
    elif [ "$LOOK_FOR_APP_FOLDER" = "missing" ];
        then
            mkdir $APP_FOLDER
    fi
}

export SCRIPTS_FOLDER=$(pwd)        # stores full path for setup-scripts
export APP_FOLDER="$HOME/Apps"      # app folder thats made for some downloads
export PKGMGR=""                    # stores package manager name such as dnf/rpm-ostree etc
export COPYRIGHT="Copyright (c) 2021-2024 Jordan Bottoms"
export VERSION="7.21.2024"
#OS_NAME=$(source /etc/os-release ; echo $NAME)
#VERSION_ID=$(source /etc/os-release ; echo $VERSION_ID)
TEMP_FOLDER="missing"
LOOK_FOR_APP_FOLDER="missing"
#RAN_ONCE_FILE="missing"
#REPO_FOLDER="missing"               # .git folder with repository metadata
#DISTRO=""                           # stores the ID (os-release info) of the os such as fedora or debian
#VARIANT=""                          # only used for storing 'ostree' if fedora version is atomic
make_temp
make_app_folder
$SCRIPTS_FOLDER/modules/core/distro_check.sh
