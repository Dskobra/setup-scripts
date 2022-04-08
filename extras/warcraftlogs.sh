#!/usr/bin/bash

WCLOGSLINK=https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v5.8.9/Warcraft-Logs-Uploader-5.8.9.AppImage
WCLOGSBINARY=Warcraft-Logs-Uploader-5.8.9.AppImage

warcraftlogs(){
    USER=$(whoami)
    mkdir /home/$USER/Apps/warcraftlogs
    cd /home/$USER/Apps/warcraftlogs
    wget $WCLOGSLINK
    chmod +x $WCLOGSBINARY
}
warcraftlogs