#!/usr/bin/bash

gaming_apps(){
	mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
	flatpak install -y flathub com.usebottles.bottles
}


get_lutris_deps(){
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic libraqm python3-olefile python3-pillow fluid-soundfont-gs p7zip p7zip-plugins 
}

get_lutris()
{
	sudo dnf install -y lutris
}


gaming_apps
get_lutris_deps
get_lutris