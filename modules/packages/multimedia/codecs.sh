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
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/' packman-essentials
        sudo zypper ref
        sudo zypper install --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec
        sudo zypper dup --from packman-essentials --allow-vendor-change
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Slowroll/Essentials/' packman-essentials
        sudo zypper ref
        sudo zypper  install --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec
        sudo zypper dup --from packman-essentials --allow-vendor-change
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