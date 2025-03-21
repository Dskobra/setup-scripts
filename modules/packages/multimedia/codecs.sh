#!/usr/bin/bash

native_codecs(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
        sudo dnf install -y ffmpeg ffmpeg-libs.i686 ffmpeg-libs

        sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
        sudo dnf swap -y mesa-vdpau-drivers mesa-vdpau-drivers-freeworld

        sudo dnf swap -y mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686
        sudo dnf swap -y mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/' packman-essentials
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper  install --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec

        sudo zypper al Mesa Mesa-dri Mesa-gallium Mesa-libEGL1 Mesa-libGL1 Mesa-libva libgbm1
        sudo zypper dup --from packman-essentials --allow-vendor-change
        sudo zypper rl Mesa Mesa-dri Mesa-gallium Mesa-libEGL1 Mesa-libGL1 Mesa-libva libgbm1
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Slowroll/Essentials/' packman-essentials
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper  install --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec

        sudo zypper al Mesa Mesa-dri Mesa-gallium Mesa-libEGL1 Mesa-libGL1 Mesa-libva libgbm1
        sudo zypper dup --from packman-essentials --allow-vendor-change
        sudo zypper rl Mesa Mesa-dri Mesa-gallium Mesa-libEGL1 Mesa-libGL1 Mesa-libva libgbm1
    else
        echo "Unkown error has occurred."
    fi
}

native_codecs