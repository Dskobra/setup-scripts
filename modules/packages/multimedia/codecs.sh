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
        echo "1" > "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.txt
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