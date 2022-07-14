#!/usr/bin/bash

basic_apps(){
	sudo dnf install -y  java-17-openjdk brave-browser \
	plymouth-theme-spinfinity  \
	bluecurve-icon-theme lm_sensors \
	sudo plymouth-set-default-theme spinfinity -R
	flatpak install -y flathub org.keepassxc.KeePassXC
	sudo mkdir /opt/launchers
	sudo chown $USER:$USER /opt/launchers
}

basic_apps
