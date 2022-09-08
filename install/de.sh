#!/usr/bin/bash

get_desktop_extras(){
DESKTOP=$XDG_CURRENT_DESKTOP
	if [ "$DESKTOP" = "GNOME" ];
	then
		./install/de/gnome.sh
	elif [ "$DESKTOP" = "KDE" ];
	then
		./install/de/kde.sh
	elif [ "$DESKTOP" = "MATE" ];
	then
		#./install/de/mate.sh
		echo "Now setting up some extra mate features."
		sudo dnf install -y caja-dropbox caja-share \
		mate-menu
	fi
}
get_desktop_extras
