#!/usr/bin/bash

install_amd_codecs(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

        sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
        sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install mesa-va-drivers
    else
        echo "Unkown error has occurred."
    fi
}

install_amd_codecs
