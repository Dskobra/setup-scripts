#!/usr/bin/bash

cleanup(){
	sudo dnf remove -y libreoffice-core kwrite \
	gnome-shell-extension-gamemode transmission-qt
}

cleanup
