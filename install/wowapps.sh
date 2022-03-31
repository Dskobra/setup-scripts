#!/usr/bin/bash
WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.6.2/WowUp-2.6.2.AppImage
WOWUPBINARY=WowUp-2.6.2.AppImage

WAAPLINK=https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v3.3.4/weakauras-companion-3.3.4.x86_64.rpm
WAAPBINARY=weakauras-companion-3.3.4.x86_64.rpm

wowup(){
    mkdir /home/$USER/Apps/wowup 
    cd /home/$USER/Apps/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
}
weakauras(){
    cd /home/$USER/Downloads
    wget $WAAPLINK
    sudo rpm -i $WAAPBINARY
    rm $WAAPBINARY
}
wowup
weakauras
