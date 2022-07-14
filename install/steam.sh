#!/usr/bin/bash

steam_client(){
	sudo dnf install -y mangohud gamemode gamemode.i686 \
	steam-devices
	flatpak install -y flathub com.valvesoftware.Steam
	flatpak install -y flathub net.davidotek.pupgui2
	flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud
}
steam_client