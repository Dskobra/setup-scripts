#!/usr/bin/bash

gaming_apps(){
	mkdir /home/$USER/Games
	mkdir /home/$USER/Games/bottles
	flatpak install -y flathub com.usebottles.bottles
}


get_lutris_deps(){
	sudo dnf install -y gnome-desktop3 xrandr xorg-x11-server-Xephyr python3-evdev gvfs cabextract \
	python3-magic libraqm python3-olefile python3-pillow fluid-soundfont-gs p7zip p7zip-plugins 
}

get_lutris()
{
	# changed to upstream lutris due to some weird crashing on 1 computer (other computer oddly is fine), but upstream works fine.
	# 8.22.2022 lutris from fedora repos works fine now. Commenting lines for now.
	#LUTRISLINK=https://github.com/lutris/lutris/archive/refs/tags/v0.5.10.1.zip
	#LUTRISZIP=v0.5.10.1.zip
	#cd /home/$USER/Downloads
	#wget $LUTRISLINK
	#unzip $LUTRISZIP
	#mv lutris* lutris 
	#sudo mv lutris /opt/lutris
	#sudo ln -s "/opt/lutris/bin/lutris" "/usr/bin/lutris"
	sudo dnf install -y lutris
}

get_lutris_beta(){
	 flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
	 flatpak update --appstream
	 flatpak install flathub org.gnome.Platform.Compat.i386 org.freedesktop.Platform.GL32.default org.freedesktop.Platform.GL.default
	 flatpak install -y flathub-beta net.lutris.Lutris
}


gaming_apps
get_lutris_deps
get_lutris
# get_lutris_beta