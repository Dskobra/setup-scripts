#!/usr/bin/bash
WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.8.2/WowUp-2.8.2.AppImage
WOWUPBINARY=WowUp-2.8.2.AppImage


wowup(){
    mkdir /home/$USER/Downloads/wowup 
    cd /home/$USER/Downloads/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    sudo mv /home/$USER/Downloads/wowup /opt/wowup
}

wowup