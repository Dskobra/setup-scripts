#!/usr/bin/bash

native_codecs(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y ffmpeg ffmpeg-libs.i686 ffmpeg-libs
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y ffmpeg
    else
        echo "Unkown error has occurred."
    fi
}

native_codecs
