#!/usr/bin/bash

# this downloads the weakauras companion
# appimage for updating weakauras
# macros in world of warcraft

download_weakauras_companion(){
    WOWLOGSLINK="https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v8.5.16/warcraftlogs-v8.5.16.AppImage"
    WOWLOGSBINARY="warcraftlogs-v8.5.16.AppImage"
    
    if test -f ~/Desktop/"$WACOMPBINARY"; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/"$WACOMPBINARY"; then
        cd  ~/Desktop/ || exit
        curl -L -o "$WACOMPBINARY" "$WACOMPLINK"
        chmod +x "$WACOMPBINARY"
    fi
}

download_weakauras_companion
