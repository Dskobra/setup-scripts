#!/usr/bin/bash

# downloads the official jetbrains pycharm community edition

install_pycharm(){
    cd "$SCRIPTS_FOLDER"/temp || exit
    source "$SCRIPTS_FOLDER"/data/packages.conf
    if test -d "$APP_FOLDER"/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d "$APP_FOLDER"/pycharm; then
        cd "$SCRIPTS_FOLDER"/temp || exit
        curl -L -o pycharm.tar.gz "$PYCHARM_LINK"
        tar -xvf pycharm.tar.gz
        rm pycharm.tar.gz
        mv pycharm* "$APP_FOLDER"/pycharm
    fi
}

install_pycharm
