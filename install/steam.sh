#!/usr/bin/bash

steam_client(){
	sudo dnf install -y mangohud gamemode gamemode.i686 \
	steam steam-devices
	flatpak install -y flathub net.davidotek.pupgui2
}
steam_client