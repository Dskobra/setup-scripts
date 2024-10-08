#!/usr/bin/bash

# this downloads the weakauras companion
# appimage for updating weakauras
# macros in world of warcraft

download_weakauras_companion(){
    cd "$SCRIPTS_FOLDER"/temp || exit
    source "$SCRIPTS_FOLDER"/data/packages.conf
    if test -f ~/Desktop/"$WACOMPBINARY"; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/"$WACOMPBINARY"; then
        cd  ~/Desktop/ || exit
        curl -L -o "$WACOMPBINARY" "$WACOMPLINK"
        chmod +x "$WACOMPBINARY"
    fi
}

download_weakauras_companion
