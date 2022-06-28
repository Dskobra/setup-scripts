#!/usr/bin/bash

coding_tools(){

	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf install -y python3-tools python3-devel git-gui \
	java-17-openjdk-devel
	flatpak install -y flathub io.github.shiftey.Desktop
	flatpak install -y flathub org.geany.Geany

}
coding_tools