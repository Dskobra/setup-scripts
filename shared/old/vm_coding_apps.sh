#!/usr/bin/bash

coding_apps(){
	curl -sL https://rpm.nodesource.com/setup_lts.x | sudo bash -
	sudo dnf install -y python3-tools python3-devel vim-enhanced
	sudo dnf install -y nodejs
	flatpak install -y flathub org.gnu.emacs
	flatpak install -y flathub io.atom.Atom
	flatpak install -y flathub nl.openoffice.bluefish
}

coding_apps
