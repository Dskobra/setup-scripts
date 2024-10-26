#!/usr/bin/bash

### This is for swapping the mesa codecs from rpmfusion
### back to the limited ones from Fedora repos.
remove_amd_codecs(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
        sudo dnf remove -y mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
        sudo rpm-ostree uninstall mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "This is only for Fedora as it swaps the RPMFusion mesa codecs"
        echo "for the Fedora provided ones which only uses patent free codecs."
    else
        echo "Unkown error has occurred."
    fi
}

remove_amd_codecs
