#!/usr/bin/bash

install_kde_extras(){
	echo "Now setting up some extra kde features."
	sudo dnf install -y dolphin-plugins \
	kate zenity ark digikam kde-connect konversation \
	kpat ktorrent krusader
	flatpak install -y flathub com.dropbox.Client
}
install_kde_extras