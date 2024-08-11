#!/usr/bin/bash

install_v4l2loopback(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y akmod-v4l2loopback v4l2loopback
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install -y akmod-v4l2loopback v4l2loopback
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y v4l2loopback-dkms v4l2loopback-utils
        sudo echo "v4l2loopback" | sudo tee /etc/modules-load.d/v4l2loopback.conf 
        sudo echo "options v4l2loopback video_nr=10 card_label=\"OBS Video Source\" exclusive_caps=1" | sudo tee /etc/modprobe.d/v4l2loopback.conf

        sudo update-initramfs -c -k $(uname -r)
    else
        echo "Unkown error has occurred."
    fi
}

install_v4l2loopback