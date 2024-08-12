#!/usr/bin/bash

install_eclipse(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    curl -o eclipse.tar.gz $ECLIPSE_LINK

    tar -xvf eclipse.tar.gz
    ./eclipse-installer/eclipse-inst
}

install_eclipse