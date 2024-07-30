#!/usr/bin/bash

install_scene_builder(){
    cd $SCRIPTS_FOLDER/temp
    source $SCRIPTS_FOLDER/data/packages.conf
    if [ $PKGMGR == "dnf" ]
    then
        curl -L -o scenebuilder.rpm $SCENE_BUILDER_RPM_LINK
        sudo rpm -i scenebuilder.rpm
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        curl -L -o scenebuilder.rpm $SCENE_BUILDER_RPM_LINK
        sudo rpm-ostree install scenebuilder.rpm
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        curl -L -o scenebuilder.deb $SCENE_BUILDER_DEB_LINK
        sudo dpkg -i scenebuilder.deb
    else
        echo "Unkown error has occurred."
    fi
}

install_scene_builder