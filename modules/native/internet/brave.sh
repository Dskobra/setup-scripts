#!/usr/bin/bash

install_brave_browser(){
    cd "$SCRIPTS_FOLDER"/temp
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf4 config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
        sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
        sudo dnf update -y
        sudo dnf install -y brave-browser
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
        sudo apt-get update
        sudo apt-get install -y brave-browser
    else
        echo "Unkown error has occurred."
    fi
}

flatpak uninstall --user -y com.brave.Browser
install_brave_browser
