#!/usr/bin/bash

# installs the latest nodejs LTS release using nvm (node version manager)
# which helps manage multiple nodejs installs.

install_nodejs(){
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
	source ~/.bashrc
    nvm install lts/*
}

install_nodejs
