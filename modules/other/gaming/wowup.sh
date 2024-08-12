#!/usr/bin/bash


download_wowup(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -f ~/Desktop/$WOWUPBINARY; then
        echo "WoWUp already downloaded."
    elif ! test -f ~/Desktop/$WOWUPBINARY; then
        cd ~/Desktop/
        curl -L -o $WOWUPBINARY $WOWUPLINK 
        chmod +x $WOWUPBINARY
    fi
}

download_wowup