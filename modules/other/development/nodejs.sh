#!/usr/bin/bash

# installs the node version manager script for
# managing multiple nodejs. this installs the latest 
#LTS release.

install_nodejs(){
    test -d "$HOME"/.nvm && NVM_FOLDER="exists"
    if [ "$NVM_FOLDER" = "exists" ];
        then
           nvm install lts/*
    elif [ "$NVM_FOLDER" = "missing" ];
        then
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
			zenity --info --text="Please rerun this option after restarting your shell otherwise it won't see nvm"

    fi
}
NVM_FOLDER="missing"
install_nodejs
