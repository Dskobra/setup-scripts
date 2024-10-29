#!/usr/bin/bash

### This is for swapping the ffmpeg codecs from rpmfusion
### back to the limited ones from Fedora repos.
remove_ffmpeg(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf swap -y ffmpeg ffmpeg-free --allowerasing
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall ffmpeg
        sudo rpm-ostree override reset ffmpeg-free libavcodec-free libavdevice-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "================================================================"
        echo "This is only for Fedora as it swaps the RPMFusion ffmpeg"
        echo "for the Fedora provided ones which only uses patent free codecs."
        echo "================================================================"
    else
        echo "Unkown error has occurred."
    fi
}

remove_ffmpeg
