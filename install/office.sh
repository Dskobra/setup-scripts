#!/usr/bin/bash

office(){
	flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y flathub org.qownnotes.QOwnNotes
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub im.pidgin.Pidgin
}

office
