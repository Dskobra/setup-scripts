#!/usr/bin/bash

internet_apps(){
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub im.pidgin.Pidgin
}

internet_apps
