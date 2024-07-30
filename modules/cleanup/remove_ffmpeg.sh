#!/usr/bin/bash

### This is mostly for swapping the ffmpeg codecs from rpmfusion
### back to the limited ones from Fedora repos.
remove_codecs(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf update -y
        sudo dnf swap -y ffmpeg libavcodec-free --allowerasing
        sudo dnf remove -y gstreamer1-plugin-openh264 \
        mozilla-openh264
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree remove ffmpeg
        sudo rpm-ostree override reset libavcodec-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free \
        libswresample-free libswscale-free
        sudo rpm-ostree override reset mesa-va-drivers mesa-vdpau-drivers-freeworld
        
        sudo rpm-ostree remove -y gstreamer1-plugin-openh264 \
        mozilla-openh264
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        TEXT_ONE="This is only for Fedora as it swaps the RPMFusion ffmpeg"
        TEXT_TWO="for the Fedora provided one which only uses patent free codecs."
        zenity --error --text="$TEXT_ONE $TEXT_TWO"
    else
        echo "Unkown error has occurred."
    fi
}

remove_codecs