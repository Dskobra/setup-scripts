#!/usr/bin/bash
native_jdk(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y adoptium-temurin-java-repository
        sudo sed -i '/enabled=0/c enabled=1' /etc/yum.repos.d/adpotium-temurin-java-repository.repo
        sudo dnf update -y
        sudo dnf install -y temurin-21-jdk
        sudo alternatives --set java /usr/lib/jvm/temurin-21-jdk/bin/java
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        echo "Temurin is only available on openSUSE Leap/SLES."
    else
        echo "Unkown error has occurred."
    fi
}

download_openjdk(){
    if test -d /opt/apps/openjdk21; then
        echo "openjdk21 already downloaded."
    elif ! test -d /opt/apps/openjdk21; then
        cd /opt/apps/temp || exit
        # script provided by Adoptium Temurin https://github.com/adoptium/api.adoptium.net/blob/main/docs/cookbook.adoc#example-two
        set -eu

        # Specify the Java version and platform
        API_URL="https://api.adoptium.net/v3/binary/latest/21/ga/linux/x64/jdk/hotspot/normal/eclipse"

        # Fetch the archive
        FETCH_URL=$(curl -s -w %{redirect_url} "${API_URL}")
        FILENAME=$(curl -OLs -w %{filename_effective} "${FETCH_URL}")

        # Validate the checksum
        curl -Ls "${FETCH_URL}.sha256.txt" | sha256sum -c --status

        echo "Downloaded successfully as ${FILENAME}"

        tar -xvf OpenJDK21U-jdk_x64_linux_hotspot_21.*.tar.gz
        mv jdk-21* openjdk21
        mv openjdk21 /opt/apps/openjdk21
        rm /opt/apps/temp/OpenJDK21U-jdk_x64_linux_hotspot_21.*.tar.gz
        echo "Temurin openJDK 21 LTS is located at /opt/apps/openjdk21" >> "$SCRIPTS_FOLDER"/install.txt 
        echo "================================================================"
        echo "Temurin openJDK 21 LTS is located at $OPENJDK_LOCATION"
        echo "================================================================"

    fi
}

download_openjfx(){
    OPENJFX_LINK="https://download2.gluonhq.com/openjfx/21.0.6/openjfx-21.0.6_linux-x64_bin-sdk.zip"
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
    IDEA_LINK="https://download.jetbrains.com/idea/ideaIC-2024.3.3.tar.gz"
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
    PYCHARM_LINK="https://download.jetbrains.com/python/pycharm-community-2024.3.3.tar.gz"
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