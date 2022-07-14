#!/usr/bin/bash

gaming_apps(){
	mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
	flatpak install -y flathub com.usebottles.bottles
	flatpak install -y flathub net.davidotek.pupgui2
}


getlutris()
{
	# changed to upstream lutris due to some weird crashing on 1 computer (other computer oddly is fine), but upstream works fine.
	LUTRISLINK=https://github.com/lutris/lutris/archive/refs/tags/v0.5.10.1.zip
	LUTRISZIP=v0.5.10.1.zip
	cd /home/$USER/Downloads
	wget $LUTRISLINK
	unzip $LUTRISZIP
	mv lutris* lutris 
	sudo mv lutris /opt/lutris
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic libraqm python3-olefile python3-pillow
	sudo ln -s "/opt/lutris/bin/lutris" "/usr/bin/lutris"
}
gaming_apps
getlutris
