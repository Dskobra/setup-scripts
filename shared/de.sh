#!/usr/bin/bash

DESKTOP=0

get_desktop_extras(){
test -f /usr/bin/gnome-session && DESKTOP=gnome
test -f /usr/bin/plasma_session && DESKTOP=kde
test -f /usr/bin/mate-session && DESKTOP=mate
test -f /usr/bin/xfce4-panel && DESKTOP=xfce
	if [ "$DESKTOP" = "gnome" ];
	then
		./de/gnome.sh
	elif [ "$DESKTOP" = "kde" ];
	then
		./de/kde.sh
	elif [ "$DESKTOP" = "mate" ];
	then
		./de/mate.sh
	elif [ "$DESKTOP" = "xfce" ];
	then
		./de/xfce.sh
	fi
}
get_desktop_extras
