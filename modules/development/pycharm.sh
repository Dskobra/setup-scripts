#!/usr/bin/bash

install_pycharm(){
    echo "-------Pick an option-------"
    echo "(1) download a compressed bundle"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is a bundle extracted from an archive. Stored in ~/Apps/pycharm"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        download_pycharm
    elif [ "$input" = 2 ] 
    then
        flatpak install --user -y flathub com.jetbrains.PyCharm-Community
    elif [ "$input" = 3 ]
    then
        package_help_page
    else
        echo "Unkown error has occurred."
    fi
}

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

install_pycharm