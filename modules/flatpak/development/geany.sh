#!/usr/bin/bash

remove_geany(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

flatpak install --user -y flathub org.geany.Geany
remove_geany
