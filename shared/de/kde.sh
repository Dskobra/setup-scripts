#!/usr/bin/bash

kde(){
	echo "Now setting up some extra kde features."
	sudo dnf groupinstall -y "Firefox Web Browser"
	sudo dnf install -y  dolphin-plugins \
	kate ark kde-connect kleopatra zenity
	flatpak install -y flathub com.dropbox.Client
}
kde