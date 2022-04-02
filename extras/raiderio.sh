#!/usr/bin/bash

raiderio(){
    # due to the cdn they use I can't download the appimage directly.
    mkdir /home/$USER/Apps/raiderio
    firefox https://raider.io/addon
    USER=$(whoami)
    cd /home/$USER/Apps/raiderio/
    chmod +x RaiderIO_Client.AppImage
}
raiderio