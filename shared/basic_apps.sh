#!/usr/bin/bash

basic_apps(){
	sudo dnf install -y vim-enhanced java-11-openjdk
	flatpak install -y flathub org.keepassxc.KeePassXC
}

basic_apps
