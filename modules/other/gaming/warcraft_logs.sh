#!/usr/bin/bash

download_warcraft_logs(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -f ~/Desktop/$WOWLOGSBINARY; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f ~/Desktop/$WOWLOGSBINARY; then
        cd ~/Desktop/
        curl -L -o $WOWLOGSBINARY $WOWLOGSLINK
        chmod +x $WOWLOGSBINARY
    fi
}

download_warcraft_logs