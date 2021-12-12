#!/usr/bin/bash

gnome(){
	sudo dnf install -y menulibre pavucontrol \
	gnome-tweaks nautilus-dropbox openssl \
	humanity-icon-theme bluecurve-icon-theme
	flatpak install -y flathub org.gnome.Extensions
}
gnome
