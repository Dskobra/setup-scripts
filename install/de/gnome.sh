#!/usr/bin/bash

gnome(){
	echo "Now setting up some extra gnome features."
	sudo dnf install -y menulibre pavucontrol \
	gnome-tweaks nautilus-dropbox file-roller \
	gnome-shell-extension-appindicator openssl \
	humanity-icon-theme 
	flatpak install -y flathub org.gnome.Extensions
}
gnome
