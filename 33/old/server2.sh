#!/usr/bin/bash

DESKTOP=0
repos(){
	echo "Setting up rpmfusion"
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf update -y
}
amd(){
	./shared/amd.sh
}

get_desktop_extras(){
test -f /usr/bin/gnome-session && DESKTOP=gnome
test -f /usr/bin/plasma_session && DESKTOP=kde
test -f /usr/bin/mate-session && DESKTOP=mate
test -f /usr/bin/xfce4-panel && DESKTOP=xfce
	if [ "$DESKTOP" = "gnome" ];
	then
		sudo dnf install -y gnome-tweaks
	elif [ "$DESKTOP" = "mate" ];
	then
		sudo dnf install -y caja-share
	elif [ "$DESKTOP" = "xfce" ];
	then
		sudo dnf install -y firefox menulibre
		sudo dnf install -y gvfs-smb
	fi
}

setup_samba(){
	sudo systemctl enable smb nmb
	sudo firewall-cmd --add-service=samba --permanent
	sudo firewall-cmd --reload
	sudo mkdir /mnt/sambashare
}

repos
amd
basic_apps
server_apps
setup_samba
