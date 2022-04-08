#!/usr/bin/bash

raiderio(){
    # due to the cdn they use I can't download the appimage directly.
    USER=$(whoami)
    mkdir /home/$USER/Apps/raiderio
    firefox https://raider.io/addon
    cd /home/$USER/Downloads
    chmod +x RaiderIO_Client.AppImage
    mv RaiderIO_Client.AppImage /home/$USER/Apps/raiderio/
    
}
raiderio