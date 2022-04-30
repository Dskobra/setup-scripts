#!/usr/bin/bash

raiderio(){
    # due to the cdn they use I can't download the appimage directly.
    firefox https://raider.io/addon
    cd /home/$USER/Downloads
    mkdir /home/$USER/Downloads/raiderio
    chmod +x RaiderIO_Client.AppImage
    mv RaiderIO_Client.AppImage /home/$USER/Downloads/raiderio
    sudo mv raiderio /opt/raiderio
    
}
raiderio