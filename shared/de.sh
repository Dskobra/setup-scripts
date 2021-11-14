#!/usr/bin/bash

DESKTOP=0

get_desktop_extras(){
test -f /usr/bin/gnome-session && DESKTOP=gnome
test -f /usr/bin/plasma_session && DESKTOP=kde
test -f /usr/bin/mate-session && DESKTOP=mate
test -f /usr/bin/xfce4-panel && DESKTOP=xfce
	if [ "$DESKTOP" = "gnome" ];
	then
		./shared/de/gnome.sh
	elif [ "$DESKTOP" = "kde" ];
	then
		./shared/de/kde.sh
	elif [ "$DESKTOP" = "mate" ];
	then
		./shared/de/mate.sh
	elif [ "$DESKTOP" = "xfce" ];
	then
		./shared/de/xfce.sh
	fi
}
get_desktop_extras
