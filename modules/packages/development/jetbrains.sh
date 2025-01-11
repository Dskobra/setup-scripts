#!/usr/bin/bash

# downloads the official jetbrains idea community edition

download_idea(){
    IDEA_LINK="https://download.jetbrains.com/idea/ideaIC-2024.2.1.tar.gz"
    
    if test -d /opt/apps/idea; then
        echo "Intellij Idea already downloaded."
    elif ! test -d /opt/apps/idea; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o idea.tar.gz "$IDEA_LINK"
        tar -xvf idea.tar.gz
        rm idea.tar.gz
        mv idea* /opt/apps/idea
        echo "=============================================================="
        echo "Jetbrains Intellij Idea is located at $IDEA_LOCATION"
        echo "=============================================================="
    fi
}

download_pycharm(){
    PYCHARM_LINK="https://download.jetbrains.com/python/pycharm-community-2024.2.1.tar.gz"
    
    if test -d /opt/apps/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d /opt/apps/pycharm; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o pycharm.tar.gz "$PYCHARM_LINK"
        tar -xvf pycharm.tar.gz
        rm pycharm.tar.gz
        mv pycharm* "$APP_FOLDER"/pycharm
        echo "============================================================"
        echo "Jetbrains Pycharm is located at $PYCHARM_LOCATION"
        echo "============================================================"
    fi
}

IDEA_LOCATION="/opt/apps/idea"
PYCHARM_LOCATION="/opt/apps/pycharm"
if [ "$1" == "idea" ]
then
    download_idea
elif [ "$1" == "pycharm" ]
then
    download_pycharm
else
    echo "error"
fi