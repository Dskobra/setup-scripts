#!/usr/bin/bash

# this downloads the weakauras companion
# appimage for updating weakauras
# macros in world of warcraft

download_weakauras_companion(){
    WACOMPLINK="https://github.com/WeakAuras/WeakAuras-Companion/releases/download/v5.2.3/WeakAuras-Companion-5.2.3.AppImage"
    WACOMPBINARY="WeakAuras-Companion-5.2.3.AppImage"
    
    if test -f ~/Desktop/"$WACOMPBINARY"; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/"$WACOMPBINARY"; then
        cd  ~/Desktop/ || exit
        curl -L -o "$WACOMPBINARY" "$WACOMPLINK"
        chmod +x "$WACOMPBINARY"
    fi
}

download_weakauras_companion
