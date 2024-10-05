#!/usr/bin/bash

# downloads the wowup appimage
# for managing world of warcraft addons

download_wowup(){
    WOWUPLINK="https://github.com/WowUp/WowUp.CF/releases/download/v2.20.0/WowUp-CF-2.20.0.AppImage"
    WOWUPBINARY="WowUp-CF-2.20.0.AppImage"
    
    if test -f ~/Desktop/"$WOWUPBINARY"; then
        echo "WoWUp already downloaded."
    elif ! test -f ~/Desktop/"$WOWUPBINARY"; then
        cd ~/Desktop/ || exit
        curl -L -o "$WOWUPBINARY" "$WOWUPLINK"
        chmod +x "$WOWUPBINARY"
    fi
}

download_wowup
