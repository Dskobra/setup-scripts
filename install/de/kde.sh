#!/usr/bin/bash

kde(){
	echo "Now setting up some extra kde features."
	sudo dnf install -y dolphin-plugins \
	kate zenity
	flatpak install -y flathub com.dropbox.Client
}
kde