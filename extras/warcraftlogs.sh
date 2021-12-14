#!/usr/bin/bash

WCLOGSLINK=https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v5.6.4/Warcraft-Logs-Uploader-5.6.4.AppImage
WCLOGSBINARY=Warcraft-Logs-Uploader-5.6.4.AppImage

warcraftlogs(){
    mkdir ~/Games/warcraftlogs
    cd ~/Games/warcraftlogs
    wget $WCLOGSLINK
    chmod +x $WCLOGSBINARY
}
warcraftlogs