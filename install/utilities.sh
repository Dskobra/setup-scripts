#!/usr/bin/bash

install_utilities(){
	sudo dnf -y copr enable timlau/yumex-dnf
	sudo dnf install -y yumex-dnf dconf-editor \
	clamav clamav-update firewall-applet kleopatra \
	mediawriter
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
}

install_utilities
