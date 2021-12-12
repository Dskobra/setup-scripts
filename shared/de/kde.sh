#!/usr/bin/bash

kde(){
	sudo dnf install -y  dolphin-plugins \
	kate ark kde-connect kleopatra
	flatpak install -y flathub com.dropbox.Client
}
kde