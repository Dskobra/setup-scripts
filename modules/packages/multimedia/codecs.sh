#!/usr/bin/bash

native_codecs(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y ffmpeg ffmpeg-libs.i686 ffmpeg-libs\
        gstreamer1-plugins-bad-freeworld gstreamer1-plugins-bad-freeworld.i686

        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686

        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686

        
        sudo dnf swap -y mesa-vulkan-drivers mesa-vulkan-drivers-freeworld
        sudo dnf swap -y mesa-vulkan-drivers.i686 mesa-vulkan-drivers-freeworld.i686
        echo "1" > "$SCRIPTS_FOLDER"/modules/multimedia/codecs.txt
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Slowroll/Essentials/' packman-essentials
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper -n install --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec
        sudo zypper -n dup --from packman-essentials --allow-vendor-change
        echo "1" > "$SCRIPTS_FOLDER"/modules/multimedia/codecs.txt
    else
        echo "Unkown error has occurred."
    fi
}

CODECS_INSTALLED="$(cat < "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.txt)"


if [ "$CODECS_INSTALLED" == "0" ]
then
    native_codecs
else
    echo "Codecs already installed."
fi