#!/usr/bin/bash

native_geany(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install geany geany-plugins
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

remove_geany(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -rm remove geany geany-plugins
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.geany.Geany
    remove_geany
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.geany.Geany
    native_geany
else
    echo "error"
fi