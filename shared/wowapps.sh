#!/usr/bin/bash
WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.4.7/WowUp-2.4.7.AppImage
WOWUPBINARY=WowUp-2.4.7.AppImage

WAAPLINK=https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v3.3.4/weakauras-companion-3.3.4.x86_64.rpm
WAAPBINARY=weakauras-companion-3.3.4.x86_64.rpm

WCLOGSLINK=https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v5.6.4/Warcraft-Logs-Uploader-5.6.4.AppImage
WCLOGSBINARY=Warcraft-Logs-Uploader-5.6.4.AppImage

wowup(){
    mkdir ~/Games/wowup 
    cd ~/Games/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
}
weakauras(){
    cd ~/Downloads
    wget $WAAPLINK
    sudo rpm -i $WAAPBINARY
    rm $WAAPBINARY
}

warcraftlogs(){
    mkdir ~/Games/warcraftlogs
    cd ~/Games/warcraftlogs
    wget $WCLOGSLINK
    chmod +x $WCLOGSBINARY
}

raiderio(){
    # due to the cdn they use I can't download the appimage directly.
    mkdir ~/Games/raiderio
    firefox https://raider.io/addon
}
wowup
weakauras
warcraftlogs
raiderio