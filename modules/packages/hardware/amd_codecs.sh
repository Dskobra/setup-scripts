#!/usr/bin/bash

install_amd_codecs(){
    if [ "$PKGMGR" == "dnf" ]
    then
        mesa_fedora_warning
        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

        sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
        sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        mesa_fedora_warning
        sudo rpm-ostree override remove mesa-va-drivers
        sudo rpm-ostree override remove mesa-vdpau-drivers

        sudo rpm-ostree install mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install mesa-va-drivers
    else
        echo "Unkown error has occurred."
    fi
}

mesa_fedora_warning(){
    echo "=============================================================="
    echo "If you receive installation errors you will likely have to"
    echo "wait a few days to try again. This is due to needing to"
    echo "rebuild against the updated Mesa and lack of collaboration"
    echo "between Fedora package maintainers and RPMFusion which leaves"
    echo "them broken on updates."
    echo "=============================================================="
}
install_amd_codecs
