#!/usr/bin/bash

download_openjdk(){
    OPENJDK_LINK="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz"
    if test -d "$APP_FOLDER"/openjdk21; then
        echo "openjdk21 already downloaded."
    elif ! test -d "$APP_FOLDER"/openjdk21; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjdk21.tar.gz "$OPENJDK_LINK"
        tar -xvf openjdk21.tar.gz
        mv jdk-21.0.5+11 openjdk21
        rm openjdk21.tar.gz
        mv openjdk21 "$APP_FOLDER"/openjdk21
        cd $SCRIPTS_FOLDER
        echo "openjdk is stored in $APP_FOLDER/openjdk21" >> openjdx.txt 
        echo "================================================================"
        echo "Temurin openJDK 21 LTS is located at $OPENJDK_LOCATION"
        echo "================================================================"
    fi
}

download_openjfx(){
    OPENJFX_LINK="https://download2.gluonhq.com/openjfx/21.0.5/openjfx-21.0.5_linux-x64_bin-sdk.zip"
    if test -d "$APP_FOLDER"/openjfx21; then
        echo "openjfx21 already downloaded."
    elif ! test -d "$APP_FOLDER"/openjfx21; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjfx21.zip "$OPENJFX_LINK"
        unzip openjfx21.zip
        mv javafx-sdk-21.0.5 openjfx21
        rm openjfx21.zip
        mv openjfx21 "$APP_FOLDER"/openjfx21
        cd $SCRIPTS_FOLDER
        echo "openjfx is stored in $APP_FOLDER/openfx21" >> openjfx.txt
        echo "=============================================================="
        echo "Gluon openjfx 21 LTS is located at $OPENJFX_LOCATION"
        echo "=============================================================="
    fi
}

OPENJDK_LOCATION="$APP_FOLDER/openjdk21"
OPENJFX_LOCATION="$APP_FOLDER/openjfx21"
if [ "$1" == "openjdk" ]
then
    download_openjdk
elif [ "$1" == "openjfx" ]
then
    download_openjfx
else
    echo "error"
fi