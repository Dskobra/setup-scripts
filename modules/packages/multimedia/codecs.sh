#!/usr/bin/bash

native_codecs(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y ffmpeg ffmpeg-libs.i686 ffmpeg-libs
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld\
        gstreamer1-plugins-ugly gstreamer1-vaapi

        sudo rpm-ostree install gstreamer1-plugin-libav     # appeared to be installed by default so double check
        sudo rpm-ostree override remove libavdevice-free libavcodec-free libavfilter-free libavformat-free \
        libavutil-free libpostproc-free libswresample-free libswscale-free ffmpeg-free --install ffmpeg
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y ffmpeg
    else
        echo "Unkown error has occurred."
    fi
}

native_codecs

