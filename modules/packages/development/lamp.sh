#!/usr/bin/bash

native_lamp_stack(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y httpd mariadb mariadb-server\
        php phpMyAdmin
    else
        echo "Unkown error has occurred."
    fi
}

native_lamp_stack
