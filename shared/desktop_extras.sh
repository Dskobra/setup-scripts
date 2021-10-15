#!/usr/bin/bash

DESKTOP=0

get_desktop_extras(){
test -f /usr/bin/gnome-session && DESKTOP=gnome
test -f /usr/bin/plasma_session && DESKTOP=kde
test -f /usr/bin/mate-session && DESKTOP=mate
test -f /usr/bin/xfce4-panel && DESKTOP=xfce
	if [ "$DESKTOP" = "gnome" ];
	then
		sudo dnf install -y alacarte pavucontrol \
		gnome-tweaks nautilus-dropbox openssl \
		humanity-icon-theme bluecurve-icon-theme
		flatpak install -y flathub org.gnome.Extensions
	elif [ "$DESKTOP" = "kde" ];
	then
		sudo dnf install -y  dolphin-plugins \
		kate ark kde-connect kleopatra
		flatpak install -y flathub com.dropbox.Client
	elif [ "$DESKTOP" = "mate" ];
	then
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
	elif [ "$DESKTOP" = "xfce" ];
	then
		sudo dnf install -y firefox menulibre \
		dropbox gvfs-smb xarchiver
		sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
	fi
}
get_desktop_extras
