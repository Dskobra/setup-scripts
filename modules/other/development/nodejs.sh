#!/usr/bin/bash

# installs the node version manager script for
# managing multiple nodejs. this installs the latest 
#LTS release.

install_nodejs(){
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_nodejs