#!/usr/bin/bash

DESKTOP=0

get_desktop_extras(){
test -f /usr/bin/gnome-session && DESKTOP=gnome
test -f /usr/bin/plasma_session && DESKTOP=kde
test -f /usr/bin/mate-session && DESKTOP=mate
test -f /usr/bin/xfce4-panel && DESKTOP=xfce
	if [ "$DESKTOP" = "gnome" ];
	then
		sudo dnf install -y nautilus-dropbox gnome-tweaks \
		pavucontrol alacarte openssl \
		nautilus-python nautilus-extensions
		flatpak install -y flathub org.gnome.Extensions
	elif [ "$DESKTOP" = "kde" ];
	then
		sudo dnf install -y  dolphin-plugins dropbox \
		kate ark kde-connect
	elif [ "$DESKTOP" = "mate" ];
	then
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
	elif [ "$DESKTOP" = "xfce" ];
	then
		sudo dnf install -y firefox menulibre \
		dropbox gvfs-smb \
		xarchiver
		sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
	fi
}

get_desktop_extras
