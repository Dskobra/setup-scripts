#!/usr/bin/bash

get_desktop_extras(){
test -f /usr/bin/gnome-session && DESKTOP=gnome
test -f /usr/bin/plasma_session && DESKTOP=kde
test -f /usr/bin/mate-session && DESKTOP=mate
test -f /usr/bin/xfce4-panel && DESKTOP=xfce

	if [ "$DESKTOP" = "gnome" ];
	then
		./install/de/gnome.sh
	elif [ "$DESKTOP" = "kde" ];
	then
		./install/de/kde.sh
	elif [ "$DESKTOP" = "mate" ];
	then
		./install/de/mate.sh
	elif [ "$DESKTOP" = "xfce" ];
	then
		./install/de/xfce.sh
	fi
}
DESKTOP=0
get_desktop_extras
