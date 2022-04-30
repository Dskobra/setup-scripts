#!/usr/bin/bash

WCLOGSLINK=https://github.com/RPGLogs/Uploaders-warcraftlogs/releases/download/v5.8.9/Warcraft-Logs-Uploader-5.8.9.AppImage
WCLOGSBINARY=Warcraft-Logs-Uploader-5.8.9.AppImage

warcraftlogs(){
    mkdir /home/$USER/Downloads/warcraftlogs
    cd /home/$USER/Downloads/warcraftlogs
    wget $WCLOGSLINK
    chmod +x $WCLOGSBINARY
    sudo mv /home/$USER/Downloads/warcraftlogs /opt/warcraftlogs
}
warcraftlogs