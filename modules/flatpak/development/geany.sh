#!/usr/bin/bash

remove_geany(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

flatpak install --user -y flathub org.geany.Geany
remove_geany
