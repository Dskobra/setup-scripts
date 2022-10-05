#!/usr/bin/bash

install_wowup(){
    WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.9.0/WowUp-2.9.0.AppImage
    WOWUPBINARY=WowUp-2.9.0.AppImage
    mkdir /home/$USER/Downloads/wowup 
    cd /home/$USER/Downloads/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    sudo mv /home/$USER/Downloads/wowup /opt/wowup
}

install_wowup