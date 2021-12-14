#!/usr/bin/bash

internet_apps(){
	sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 brave-browser
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub im.pidgin.Pidgin
}

internet_apps
