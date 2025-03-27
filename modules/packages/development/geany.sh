#!/usr/bin/bash

native_geany(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install geany geany-plugins
    else
        echo "Invalid option"
    fi
}

native_geany