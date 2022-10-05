#!/usr/bin/bash

install_bottles(){
	mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
	flatpak install -y flathub com.usebottles.bottles
}

install_lutris()
{
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic libraqm python3-olefile python3-pillow fluid-soundfont-gs p7zip p7zip-plugins 
	sudo dnf install -y lutris
}


install_bottles
install_lutris