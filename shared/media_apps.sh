#!/usr/bin/bash

media_apps(){
	sudo dnf install -y ffmpeg
	flatpak install -y flathub org.videolan.VLC
	flatpak install -y flathub com.obsproject.Studio
	flatpak install -y flathub org.openshot.OpenShot
	flatpak install -y flathub org.gimp.GIMP
}

media_apps
