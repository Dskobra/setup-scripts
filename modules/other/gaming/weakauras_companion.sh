#!/usr/bin/bash

download_weakauras_companion(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -f ~/Desktop/$WACOMPBINARY; then
        echo "WeakAuras Companion already downloaded."
    elif ! test -f  ~/Desktop/$WACOMPBINARY; then
        cd  ~/Desktop/
        curl -L -o $WACOMPBINARY $WACOMPLINK
        chmod +x $WACOMPBINARY
    fi
}

download_weakauras_companion