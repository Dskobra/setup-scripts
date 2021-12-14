#!/usr/bin/bash

basic_apps(){
	sudo dnf install -y vim-enhanced java-11-openjdk
	sudo dnf install -y brave-browser
	flatpak install -y flathub org.keepassxc.KeePassXC
	mkdir ~/Apps 
	mkdir ~/Apps/launchers
}

basic_apps
