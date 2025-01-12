#!/usr/bin/bash

# downloads the wowup appimage
# for managing world of warcraft addons

download_wowup(){
    WOWUPLINK="https://github.com/WowUp/WowUp.CF/releases/download/v2.20.0/WowUp-CF-2.20.0.AppImage"
    WOWUPBINARY="WowUp-CF-2.20.0.AppImage"
    
    if test -f /opt/apps/appimages"$WOWUPBINARY"; then
        echo "WoWUp already downloaded."
    elif ! test -f /opt/apps/appimages"$WOWUPBINARY"; then
        cd /opt/apps/appimages || exit
        curl -L -o "$WOWUPBINARY" "$WOWUPLINK"
        chmod +x "$WOWUPBINARY"

        curl -L -o $SCRIPTS_FOLDER/temp/wowup.png https://cdn.wowup.io/site/production/assets/images/wowup_white_lg_nopad.png
        mv $SCRIPTS_FOLDER/temp/wowup.png /opt/apps/icons

        cd $SCRIPTS_FOLDER/modules/packages/gaming/
        chmod +x wowup.sh
        mv $SCRIPTS_FOLDER/modules/packages/gaming/wowup.sh /home/$USER/bin/wowup
        mv $SCRIPTS_FOLDER/modules/packages/gaming/wowup.desktop /home/$USER/Desktop/wowup.desktop

    fi
}

download_warcraft_logs(){
    WOWLOGSLINK="https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v8.5.16/warcraftlogs-v8.5.16.AppImage"
    WOWLOGSBINARY="warcraftlogs-v8.5.16.AppImage"
    
    if test -f /opt/apps/appimages"$WOWLOGSBINARY"; then
        echo "Warcraft Logs already downloaded."
    elif ! test -f /opt/apps/appimages"$WOWLOGSBINARY"; then
        cd /opt/apps/appimages || exit
        curl -L -o "$WOWLOGSBINARY" "$WOWLOGSLINK"
        chmod +x "$WOWLOGSBINARY"

        curl -L -o $SCRIPTS_FOLDER/temp/warcraft_logs.png https://assets.rpglogs.com/img/warcraft/favicon.png
        mv $SCRIPTS_FOLDER/temp/warcraft_logs.png /opt/apps/icons

        cd $SCRIPTS_FOLDER/modules/packages/gaming/
        chmod +x warcraft_logs.sh
        mv $SCRIPTS_FOLDER/modules/packages/gaming/warcraft_logs.sh /home/$USER/bin/warcraft_logs
        mv $SCRIPTS_FOLDER/modules/packages/gaming/warcraft_logs.desktop /home/$USER/Desktop/warcraft_logs.desktop
    fi
}

download_weakauras_companion(){
    WACOMPLINK="https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v5.2.3/WeakAuras-Companion-5.2.3.AppImage"
    WACOMPBINARY="WeakAuras-Companion-5.2.3.AppImage"
    
    if test -f ~/opt/apps/appimages"$WACOMPBINARY"; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  /opt/apps/appimages"$WACOMPBINARY"; then
        cd  /opt/apps/appimages || exit
        curl -L -o "$WACOMPBINARY" "$WACOMPLINK"
        chmod +x "$WACOMPBINARY"

        curl -L -o $SCRIPTS_FOLDER/temp/weakauras.png https://github.com/WeakAuras/WeakAuras-Companion/blob/v5.2.7/src/assets/weakauras.png?raw=true
        mv $SCRIPTS_FOLDER/temp/weakauras.png /opt/apps/icons

        cd $SCRIPTS_FOLDER/modules/packages/gaming/
        chmod +x wa_companion.sh
        mv $SCRIPTS_FOLDER/modules/packages/gaming/wa_companion.sh /home/$USER/bin/wa_companion
        mv $SCRIPTS_FOLDER/modules/packages/gaming/wa_companion.desktop /home/$USER/Desktop/wa_companion.desktop
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