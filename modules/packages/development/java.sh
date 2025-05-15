#!/usr/bin/bash
native_jdk(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y adoptium-temurin-java-repository
        sudo sed -i '/enabled=0/c enabled=1' /etc/yum.repos.d/adoptium-temurin-java-repository.repo
        sudo dnf update -y
        sudo dnf install -y temurin-21-jdk
        sudo alternatives --set java /usr/lib/jvm/temurin-21-jdk/bin/java
    else
        echo "Unkown error has occurred."
    fi
}

download_openjfx(){
    OPENJFX_LINK="https://download2.gluonhq.com/openjfx/21.0.7/openjfx-21.0.7_linux-x64_bin-sdk.zip"
    if test -d /opt/apps/openjfx21; then
        echo "openjfx21 already downloaded."
    elif ! test -d /opt/apps/openjfx21; then
        cd /opt/apps/temp || exit
        curl -L -o openjfx21.zip "$OPENJFX_LINK"
        unzip openjfx21.zip
        mv javafx-sdk-21* openjfx21
        mv openjfx21 /opt/apps/openjfx21
        rm /opt/apps/temp/openjfx21.zip
        echo "Gluon openjfx 21 LTS is located at /opt/apps/openfx21" >> "$SCRIPTS_FOLDER"/install.txt
        echo "=============================================================="
        echo "Gluon openjfx 21 LTS is located at $OPENJFX_LOCATION"
        echo "=============================================================="
    fi
}

download_idea(){
    IDEA_LINK="https://download.jetbrains.com/idea/ideaIC-2025.1.tar.gz"
    if test -d /opt/apps/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d /opt/apps/idea; then
        cd /opt/apps/temp || exit
        curl -L -o idea.tar.gz "$IDEA_LINK"
        tar -xvf idea.tar.gz
        rm /opt/apps/temp/idea.tar.gz
        mv /opt/apps/temp/idea* /opt/apps/idea
        
        echo "Jetbrains Intellij Idea is located at /opt/apps/idea" >> "$SCRIPTS_FOLDER"/install.txt
        echo "=============================================================="
        echo "Jetbrains Intellij Idea is located at $IDEA_LOCATION"
        echo "=============================================================="
    fi
}

download_pycharm(){
    PYCHARM_LINK="https://download.jetbrains.com/python/pycharm-community-2025.1.tar.gz"
    if test -d /opt/apps/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d /opt/apps/pycharm; then
        cd /opt/apps/temp || exit
        curl -L -o pycharm.tar.gz "$PYCHARM_LINK"
        tar -xvf pycharm.tar.gz
        rm /opt/apps/temp/pycharm.tar.gz
        mv /opt/apps/temp/pycharm* /opt/apps/pycharm
        echo "Jetbrains Pycharm is located at /opt/apps/pycharm" >> "$SCRIPTS_FOLDER"/install.txt 
        echo "============================================================"
        echo "Jetbrains Pycharm is located at $PYCHARM_LOCATION"
        echo "============================================================"
    fi
}

OPENJFX_LOCATION="/opt/apps/openjfx21"
IDEA_LOCATION="/opt/apps/idea"
PYCHARM_LOCATION="/opt/apps/pycharm"

if [ "$1" == "openjdk" ]
then
    native_jdk
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
