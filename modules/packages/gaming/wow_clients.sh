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

download_weakauras_companion(){
    WACOMPLINK="https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v5.2.3/WeakAuras-Companion-5.2.3.AppImage"
    WACOMPBINARY="WeakAuras-Companion-5.2.3.AppImage"
    
    if test -f ~/Desktop/"$WACOMPBINARY"; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/"$WACOMPBINARY"; then
        cd  ~/Desktop/ || exit
        curl -L -o "$WACOMPBINARY" "$WACOMPLINK"
        chmod +x "$WACOMPBINARY"
    fi
}

if [ "$1" == "wowup" ]
then
    download_wowup
elif [ "$1" == "wclogs" ]
then
    download_warcraft_logs

elif [ "$1" == "wacompanion" ]
then
    download_weakauras_companion
else
    echo "error"
fi