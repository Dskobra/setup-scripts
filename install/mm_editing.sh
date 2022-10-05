#!/usr/bin/bash

install_mm_tools(){
	sudo dnf install -y kolourpaint
	flatpak install -y flathub com.obsproject.Studio
	flatpak install -y flathub org.openshot.OpenShot
}

install_mm_tools