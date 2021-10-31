#!/usr/bin/bash
WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.4.7/WowUp-2.4.7.AppImage
WOWUPBINARY=WowUp-2.4.7.AppImage
WAAPLINK=https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v3.3.4/weakauras-companion-3.3.4.x86_64.rpm
WAAPBINARY=weakauras-companion-3.3.4.x86_64.rpm
WCLOGSLINK=https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v5.6.4/Warcraft-Logs-Uploader-5.6.4.AppImage
WCLOGSBINARY=Warcraft-Logs-Uploader-5.6.4.AppImage

wowup(){
    cd ~/Games
    mkdir wowup 
    cd wowup 
    wget WOWUPLINK
    chmod +x WOWUPBINARY
}
weakauras(){
    cd ~/Downloads
    wget WAAPLINK
    sudo rpm -i WAAPBINARY
    rm WAAPBINARY
}

warcraftlogs(){
    cd ~/Games
    mkdir warcraftlogs
    cd warcraftlogs
    wget WCLOGSLINK
    chmod +x WCLOGSBINARY
}

wowup
weakauras
warcraftlogs