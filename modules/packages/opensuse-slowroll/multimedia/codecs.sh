#!/usr/bin/bash

native_codecs(){
    sudo zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Slowroll/Essentials/' packman-essentials
    sudo zypper --gpg-auto-import-keys ref
    # note try this code out once packman fixes its dependency issues again <_<
    # sudo zypper -n dup --allow-vendor-change --allow-downgrade --from packman-essentials
    sudo zypper -n install --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec
    sudo zypper -n dup --from packman-essentials --allow-vendor-change
    echo "1" > "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt
}

CODECS_INSTALLED="$(cat < "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.txt)"


if [ "$CODECS_INSTALLED" == "0" ]
then
    native_codecs
    #zenity --error --text="Packman-Essentials currently is having dependency issues. So this is disabled."
else
    echo "Codecs already installed."
fi
