#!/usr/bin/bash

native_lamp_stack(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install apache2 mariadb php8 phpMyAdmin
    else
        echo "Unkown error has occurred."
    fi
}

native_lamp_stack
