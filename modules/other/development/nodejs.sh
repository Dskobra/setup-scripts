#!/usr/bin/bash

install_nodejs(){
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_nodejs