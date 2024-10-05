#!/usr/bin/bash

# this downloads the warcraft logs appimage
# for uploading raid logs to warcraftlogs.com
# for the world of warcraft online game


download_warcraft_logs(){
    WACOMPLINK="https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v5.2.3/WeakAuras-Companion-5.2.3.AppImage"
    WACOMPBINARY="WeakAuras-Companion-5.2.3.AppImage"
    
    if test -f ~/Desktop/"$WOWLOGSBINARY"; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f ~/Desktop/"$WOWLOGSBINARY"; then
        cd ~/Desktop/ || exit
        curl -L -o "$WOWLOGSBINARY" "$WOWLOGSLINK"
        chmod +x "$WOWLOGSBINARY"
    fi
}

download_warcraft_logs
