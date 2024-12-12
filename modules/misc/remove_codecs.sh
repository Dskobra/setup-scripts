#!/usr/bin/bash

### This is for swapping the ffmpeg codecs from rpmfusion
### back to the limited ones from Fedora repos.
remove_ffmpeg(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf swap -y ffmpeg ffmpeg-free --allowerasing

        sudo dnf remove -y mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
        sudo dnf remove -y mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree uninstall ffmpeg
        sudo rpm-ostree override reset ffmpeg-free libavcodec-free libavdevice-free libavfilter-free \
        libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free

        sudo rpm-ostree uninstall mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
        sudo rpm-ostree uninstall mesa-va-drivers-freeworld.i686 mesa-vdpau-drivers-freeworld.i686

        sudo rpm-ostree override reset mesa-va-drivers
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "debian" ]
    then
        echo "================================================================"
        echo "This is only for Fedora as it swaps the RPMFusion media codecs"
        echo "for the Fedora provided ones which are patent free."
        echo "================================================================"
    else
        echo "Unkown error has occurred."
    fi
}

remove_ffmpeg
