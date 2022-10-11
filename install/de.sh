#!/usr/bin/bash

install_gnome_extras(){
	echo "Now setting up some extra gnome features."
	sudo dnf install -y menulibre pavucontrol \
	gnome-tweaks nautilus-dropbox file-roller \
	gnome-shell-extension-appindicator openssl \
	humanity-icon-theme gedit gedit-plugins
	flatpak install -y flathub org.gnome.Extensions
	flatpak install -y flathub com.transmissionbt.Transmission
	flatpak install -y flathub org.gimp.GIMP
}

install_kde_extras(){
	echo "Now setting up some extra kde features."
	sudo dnf install -y dolphin-plugins \
	kate zenity ark digikam kde-connect konversation \
	kpat ktorrent krusader
	flatpak install -y flathub com.dropbox.Client
}

get_desktop_extras(){
DESKTOP=$XDG_CURRENT_DESKTOP
	if [ "$DESKTOP" = "GNOME" ];
	then
		install_gnome_extras
	elif [ "$DESKTOP" = "KDE" ];
	then
		install_kde_extras
	elif [ "$DESKTOP" = "MATE" ];
	then
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
	fi
}
get_desktop_extras
