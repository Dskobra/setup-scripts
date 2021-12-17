#!/usr/bin/bash

DESKTOP=0

xfce(){
	echo "Now setting up some extra xfce features."
	sudo dnf install -y firefox menulibre \
	dropbox gvfs-smb xarchiver
	sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
}
xfce
