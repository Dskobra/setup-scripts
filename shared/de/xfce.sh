#!/usr/bin/bash

DESKTOP=0

xfce(){
	sudo dnf install -y firefox menulibre \
	dropbox gvfs-smb xarchiver
	sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
}
xfce
