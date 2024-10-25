#!/usr/bin/bash

install_openjfx(){
    OPENJFX_LINK="https://download2.gluonhq.com/openjfx/21.0.5/openjfx-21.0.5_linux-x64_bin-sdk.zip"
    if test -d "$APP_FOLDER"/openjfx21; then
        echo "openjfx21 already downloaded."
    elif ! test -d "$APP_FOLDER"/openjfx21; then
        openjfx_header
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjfx21.zip "$OPENJFX_LINK"
        unzip openjfx21.zip
        mv javafx-sdk-21.0.5 openjfx21
        rm openjfx21.zip
        mv openjfx21 "$APP_FOLDER"/openjfx21
        cd $SCRIPTS_FOLDER
        echo "openjfx is stored in $APP_FOLDER/openfx21" >> openjfx.txt 
    fi
}

openjfx_header(){
    echo "==========================================================="
    echo "This downloads Gluon openjfx 21 LTS into ~/Apps/openjfx21"
    echo "==========================================================="
}
install_openjfx
