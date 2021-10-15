#!/usr/bin/bash

gaming_apps(){
	sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo
	sudo dnf install -y steam winehq-staging lutris
	flatpak install -y flathub com.discordapp.Discord
	cd ~
	mkdir Games
	cd Games
	wget https://launcher.mojang.com/download/Minecraft.tar.gz
	tar -xvf Minecraft.tar.gz
	rm Minecraft.tar.gz
}

gaming_apps
