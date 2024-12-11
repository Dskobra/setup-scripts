#!/usr/bin/bash

native_codecs(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y ffmpeg ffmpeg-libs.i686 ffmpeg-libs

        mesa_fedora_warning
        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

        sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
        sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        sudo rpm-ostree install gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld\
        gstreamer1-plugins-ugly gstreamer1-vaapi

        sudo rpm-ostree install gstreamer1-plugin-libav     # appeared to be installed by default so double check
        sudo rpm-ostree override remove libavdevice-free libavcodec-free libavfilter-free libavformat-free \
        libavutil-free libpostproc-free libswresample-free libswscale-free ffmpeg-free --install ffmpeg

        mesa_fedora_warning
        sudo rpm-ostree override remove mesa-va-drivers
        sudo rpm-ostree override remove mesa-vdpau-drivers

        sudo rpm-ostree install mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        opi codecs
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y ffmpeg mesa-va-drivers
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

native_codecs