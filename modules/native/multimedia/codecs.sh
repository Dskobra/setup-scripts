#!/usr/bin/bash

install_codecs(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y gstreamer1-plugin-openh264\
        mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree override remove noopenh264 --install openh264 --install mozilla-openh264

        sudo rpm-ostree override remove ffmpeg-free libavcodec-free libavdevice-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free --install ffmpeg
        sudo rpm-ostree apply-live --allow-replacement
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y ffmpeg
    else
        echo "Unkown error has occurred."
    fi
}

install_codecs