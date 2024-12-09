#!/usr/bin/bash

native_lamp_stack(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    elif [ "$PKGMGR" == "zypper" ]
    then
        sudo zypper -n install apache2 mariadb php8 phpMyAdmin
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y apache2 mariadb-client\
        mariadb-server php phpmyadmin
    else
        echo "Unkown error has occurred."
    fi
}

native_lamp_stack
