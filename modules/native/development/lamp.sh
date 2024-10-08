#!/usr/bin/bash

install_lamp_stack(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y apache2 mariadb-client\
        mariadb-server php phpmyadmin
    else
        echo "Unkown error has occurred."
    fi
}

install_lamp_stack
