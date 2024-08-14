#!/usr/bin/bash

# downloads the wowup appimage
# for managing world of warcraft addons

download_wowup(){
    cd "$SCRIPTS_FOLDER"/temp || exit
    source "$SCRIPTS_FOLDER"/data/packages.conf
    if test -f ~/Desktop/"$WOWUPBINARY"; then
        echo "WoWUp already downloaded."
    elif ! test -f ~/Desktop/"$WOWUPBINARY"; then
        cd ~/Desktop/ || exit
        curl -L -o "$WOWUPBINARY" "$WOWUPLINK "
        chmod +x "$WOWUPBINARY"
    fi
}

download_wowup
