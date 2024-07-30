#!/usr/bin/bash

install_netbeans(){
    echo "-------Pick an option-------"
    echo "(1) download a compressed bundle"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is a bundle extracted from an archive. Stored in ~/Apps/netbeans"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ] || [ -z "$input" ]
    then
        download_netbeans
    elif [ "$input" = 2 ]
    then
        flatpak install --user -y flathub org.apache.netbeans
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Unkown error has occurred."
    fi
}

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

install_netbeans