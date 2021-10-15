#!/usr/bin/bash

basic_apps(){
	sudo dnf remove -y libreoffice-core
	sudo dnf install -y dnfdragora ffmpeg dkms hplip-gui
	sudo dnf install -y gstreamer1-plugin-openh264 mozilla-openh264
	sudo dnf install -y java-11-openjdk-devel lm_sensors
	sudo dnf install -y clamav clamav-update brave-browser
	flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y flathub org.keepassxc.KeePassXC
}

basic_apps
