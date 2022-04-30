#!/usr/bin/bash
WOWUPLINK=https://github.com/WowUp/WowUp/releases/download/v2.7.0/WowUp-2.7.0.AppImage
WOWUPBINARY=WowUp-2.7.0.AppImage

WAAPLINK=https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v3.3.4/weakauras-companion-3.3.4.x86_64.rpm
WAAPBINARY=weakauras-companion-3.3.4.x86_64.rpm

wowup(){
    mkdir /home/$USER/Downloads/wowup 
    cd /home/$USER/Downloads/wowup 
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    sudo mv /home/$USER/Downloads/wowup /opt/wowup
}
weakauras(){
    cd /home/$USER/Downloads
    wget $WAAPLINK
    sudo rpm -i $WAAPBINARY
    rm $WAAPBINARY
}

raiderio(){
    # due to the cdn they use I can't download the appimage directly.
    mkdir /home/$USER/Downloads/raiderio
    firefox https://raider.io/addon
    cd /home/$USER/Downloads
    chmod +x RaiderIO_Client.AppImage
    mv RaiderIO_Client.AppImage /home/$USER/Downloads/raiderio/
    sudo mv /home/$USER/Downloads/raiderio/ /opt/raiderio
}
wowup
weakauras
raiderio
