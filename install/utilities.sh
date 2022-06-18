#!/usr/bin/bash

utilities(){
	sudo dnf -y copr enable timlau/yumex-dnf
	sudo dnf install -y dnfdragora yumex-dnf dconf-editor \
	clamav clamav-update firewall-applet
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
}

utilities
