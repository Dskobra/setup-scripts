#!/usr/bin/bash

# installs the node version manager script for
# managing multiple nodejs. this installs the latest 
#LTS release.

install_nodejs(){
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
    if [ "$DISTRO" == "fedora" ] || [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
		source ~/.bashrc
        nvm install lts/*
    elif [ "$DISTRO" == "debian" ]
    then
        # Due to some unknown reason/issue on Debian nvm is unable to be run from
        # this script. source ~/.bashrc won't work nor will rerunning this after a shell
        # restart. Manually is the only way.
        echo "==================================================="
        echo "Please open a new shell and run 'nvm install lts/*'"
        echo "==================================================="
    else
        echo "Unkown error has occurred."
    fi
}

install_nodejs

# random note, but on debian it puts nvm into ~/.nvm while fedora is ~/.config/nvm
