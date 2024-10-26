#!/usr/bin/bash

# this downloads the warcraft logs appimage
# for uploading raid logs to warcraftlogs.com
# for the world of warcraft online game


download_warcraft_logs(){
    WOWLOGSLINK="https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v8.5.16/warcraftlogs-v8.5.16.AppImage"
    WOWLOGSBINARY="warcraftlogs-v8.5.16.AppImage"
    
    if test -f ~/Desktop/"$WOWLOGSBINARY"; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f ~/Desktop/"$WOWLOGSBINARY"; then
        cd ~/Desktop/ || exit
        curl -L -o "$WOWLOGSBINARY" "$WOWLOGSLINK"
        chmod +x "$WOWLOGSBINARY"
    fi
}

download_warcraft_logs
