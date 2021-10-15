#!/usr/bin/bash

gnome(){
	sudo dnf install -y alacarte pavucontrol \
	gnome-tweaks nautilus-dropbox openssl \
	humanity-icon-theme bluecurve-icon-theme
	flatpak install -y flathub org.gnome.Extensions
}
gnome
