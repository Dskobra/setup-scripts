#!/usr/bin/bash

install_openjfx(){
    OPENJFX_LINK="https://download2.gluonhq.com/openjfx/21.0.5/openjfx-21.0.5_linux-x64_bin-sdk.zip"
    if test -d "$APP_FOLDER"/openfx21; then
        echo "openjfx21 already downloaded."
    elif ! test -d "$APP_FOLDER"/openjfx21; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjfx21.zip "$OPENJFX_LINK"
        unzip openjfx21.zip
        mv javafx-sdk-21.0.5 openjfx21
        rm openjfx21.zip
        mv openjfx21 "$APP_FOLDER"/openjfx21
    fi
}

install_openjfx
