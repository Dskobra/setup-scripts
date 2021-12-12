#!/usr/bin/bash

server_desktop(){
	sudo dnf groupinstall -y "mate desktop"
	sudo dnf install -y gnome-disk-utility
	sudo systemctl set-default graphical.target
}

server_desktop
