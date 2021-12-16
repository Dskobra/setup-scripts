#!/usr/bin/bash

office(){
	sudo dnf install -y dkms hplip-gui lm_sensors
	flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub im.pidgin.Pidgin
}

office
