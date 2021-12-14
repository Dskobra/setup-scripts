#!/usr/bin/bash

office(){
	sudo dnf install -y dkms hplip-gui lm_sensors
	flatpak install -y flathub org.libreoffice.LibreOffice
}

office
