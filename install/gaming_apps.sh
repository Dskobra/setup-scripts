#!/usr/bin/bash

gaming_apps(){
	sudo dnf install -y mangohud gamemode
	flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub io.gitlab.jstest_gtk.jstest_gtk
	flatpak install -y flathub com.valvesoftware.Steam
	flatpak install org.freedesktop.Platform.VulkanLayer.MangoHud
}

controller_setup(){
	sudo dnf install -y kernel-modules-extra
	sudo modprobe xpad
}


gaming_apps
controller_setup
