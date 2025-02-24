#!/usr/bin/bash

download_openjdk(){
    OPENJDK_LINK="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.5%2B11/OpenJDK21U-jdk_x64_linux_hotspot_21.0.5_11.tar.gz"
    if test -d /opt/apps/openjdk21; then
        echo "openjdk21 already downloaded."
    elif ! test -d /opt/apps//openjdk21; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjdk21.tar.gz "$OPENJDK_LINK"
        tar -xvf openjdk21.tar.gz
        mv jdk-21.0.5+11 openjdk21
        rm openjdk21.tar.gz
        mv openjdk21 /opt/apps/openjdk21
        cd $SCRIPTS_FOLDER
        echo "Temurin openJDK 21 LTS is located at /opt/apps/openjdk21" >> "$SCRIPTS_FOLDER"/install.txt 
        echo "================================================================"
        echo "Temurin openJDK 21 LTS is located at $OPENJDK_LOCATION"
        echo "================================================================"
    fi
}

download_openjfx(){
    OPENJFX_LINK="https://download2.gluonhq.com/openjfx/21.0.5/openjfx-21.0.5_linux-x64_bin-sdk.zip"
    if test -d /opt/apps/openjfx21; then
        echo "openjfx21 already downloaded."
    elif ! test -d /opt/apps/openjfx21; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o openjfx21.zip "$OPENJFX_LINK"
        unzip openjfx21.zip
        mv javafx-sdk-21.0.5 openjfx21
        rm openjfx21.zip
        mv openjfx21 /opt/apps/openjfx21
        cd $SCRIPTS_FOLDER
        echo "Gluon openjfx 21 LTS is located at /opt/apps/openfx21" >> "$SCRIPTS_FOLDER"/install.txt
        echo "=============================================================="
        echo "Gluon openjfx 21 LTS is located at $OPENJFX_LOCATION"
        echo "=============================================================="
    fi
}

download_idea(){
    IDEA_LINK="https://download.jetbrains.com/idea/ideaIC-2024.3.3.tar.gz"
    
    if test -d /opt/apps/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d /opt/apps/idea; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o idea.tar.gz "$IDEA_LINK"
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* /opt/apps/idea
        echo "Jetbrains Intellij Idea is located at /opt/apps/idea" >> "$SCRIPTS_FOLDER"/install.txt
        echo "=============================================================="
        echo "Jetbrains Intellij Idea is located at $IDEA_LOCATION"
        echo "=============================================================="
    fi
}

download_pycharm(){
    PYCHARM_LINK="https://download.jetbrains.com/python/pycharm-community-2024.3.3.tar.gz"
    
    if test -d /opt/apps/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d /opt/apps/pycharm; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o pycharm.tar.gz "$PYCHARM_LINK"
        tar -xvf pycharm.tar.gz
        rm pycharm.tar.gz
        mv pycharm* /opt/apps/pycharm
        echo "Jetbrains Pycharm is located at /opt/apps/pycharm" >> "$SCRIPTS_FOLDER"/install.txt 
        echo "============================================================"
        echo "Jetbrains Pycharm is located at $PYCHARM_LOCATION"
        echo "============================================================"
    fi
}

OPENJDK_LOCATION="/opt/apps/openjdk21"
OPENJFX_LOCATION="/opt/apps/openjfx21"
IDEA_LOCATION="/opt/apps/idea"
PYCHARM_LOCATION="/opt/apps/pycharm"

if [ "$1" == "openjdk" ]
then
    download_openjdk
elif [ "$1" == "openjfx" ]
then
    download_openjfx
elif [ "$1" == "idea" ]
then
    download_idea
elif [ "$1" == "pycharm" ]
then
    download_pycharm
else
    echo "error"
fi