#!/usr/bin/bash

internet_apps(){
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 brave-browser
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub im.pidgin.Pidgin
}

internet_apps
