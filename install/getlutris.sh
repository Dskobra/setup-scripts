#!/usr/bin/bash

getlutris()
{
	# changed to upstream lutris due to some weird crashing on 1 computer (other computer oddly is fine), but upstream works fine.
	sudo dnf install -y git
	cd /home/$USER/Downloads
	git clone https://github.com/lutris/lutris.git
	sudo mv lutris /opt/lutris
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic
	sudo ln -s "/opt/lutris/bin/lutris" "/usr/bin/lutris"
}

getlutris
