#!/usr/bin/bash

download_netbeans(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if test -d $APP_FOLDER/netbeans; then
        echo "Netbeans already downloaded."
    elif ! test -d $APP_FOLDER/netbeans; then
        cd $SCRIPTS_FOLDER/temp
        curl -L -o netbeans.zip $NETBEANS_LINK
        unzip netbeans.zip
        mv $SCRIPTS_FOLDER/temp/netbeans $APP_FOLDER/netbeans

    fi
}

flatpak install --user -y flathub org.apache.netbeansll_netbeans