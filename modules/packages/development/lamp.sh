#!/usr/bin/bash

native_lamp_stack(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install apache2 mariadb php8 phpMyAdmin
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y apache2 mariadb-client\
        mariadb-server php phpmyadmin
    else
        echo "Unkown error has occurred."
    fi
}

native_lamp_stack
