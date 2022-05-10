#!/usr/bin/bash

gaming_apps(){
	mkdir /home/$USER/Games
	sudo dnf install -y mangohud gamemode gamemode.i686 \
	steam-devices
	flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub com.valvesoftware.Steam
	flatpak install -y flathub com.usebottles.bottles
	flatpak install -y flathub net.davidotek.pupgui2
	flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud
}

controller_setup(){
	sudo dnf install -y kernel-modules-extra
	sudo modprobe xpad
}


gaming_apps
controller_setup
