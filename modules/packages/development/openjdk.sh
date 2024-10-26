#!/usr/bin/bash

download_openjdk(){
    OPENJDK_LINK="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz"
    if test -d "$APP_FOLDER"/openjdk21; then
        echo "openjdk21 already downloaded."
    elif ! test -d "$APP_FOLDER"/openjdk21; then
        echo "==========================================================="
        echo "This downloads Temurin openJDK 21 LTS into ~/Apps/openjdk21"
        echo "==========================================================="
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjdk21.tar.gz "$OPENJDK_LINK"
        tar -xvf openjdk21.tar.gz
        mv jdk-21.0.5+11 openjdk21
        rm openjdk21.tar.gz
        mv openjdk21 "$APP_FOLDER"/openjdk21
        cd $SCRIPTS_FOLDER
        echo "openjdk is stored in $APP_FOLDER/openjdk21" >> openjdx.txt 
    fi
}

download_openjdk
