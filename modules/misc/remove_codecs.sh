#!/usr/bin/bash

### This is for swapping the ffmpeg codecs from rpmfusion
### back to the limited ones from Fedora repos.
remove_ffmpeg(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf swap -y ffmpeg ffmpeg-free --allowerasing

        sudo dnf remove -y mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
        sudo dnf remove -y mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$DISTRO" == "debian" ]
    then
        echo "================================================================"
        echo "This is only for Fedora as it swaps the RPMFusion media codecs"
        echo "for the Fedora provided ones which are patent free. This is"
        echo "helpful when upgrading to the next release."
        echo "================================================================"
    else
        echo "Unkown error has occurred."
    fi
}

remove_ffmpeg
