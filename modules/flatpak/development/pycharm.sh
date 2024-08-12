#!/usr/bin/bash


download_pycharm(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf    
    if test -d $APP_FOLDER/pycharm; then
        echo "Pycharm already downloaded."
    elif ! test -d $APP_FOLDER/pycharm; then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o pycharm.tar.gz $PYCHARM_LINK
        tar -xvf pycharm.tar.gz
        rm pycharm.tar.gz
        mv pycharm* $APP_FOLDER/pycharm
    fi
}

flatpak install --user -y flathub com.jetbrains.PyCharm-Community