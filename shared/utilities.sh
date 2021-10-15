#!/usr/bin/bash

utilities(){
	sudo dnf install -y dnfdragora dconf-editor clamav clamav-update \
	firewall-applet
	flatpak install -y flathub org.gtkhash.gtkhash
}

utilities
