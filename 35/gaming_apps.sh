#!/usr/bin/bash
gaming_apps(){
	# temporarily use fedora 34 winehq repo on fedora 35. change when one for 35 is released.
	sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo
	sudo dnf install -y winehq-staging lutris mangohud steam
	echo "Installing world of warcraft deps for wine"
	sudo dnf install -y gnutls gnutls.i686 gnutls-devel gnutls-devel.i686 openldap openldap.i686 \
	openldap-devel openldap-devel.i686 libgpg-error libgpg-error.i686 \
	sqlite2.i686 sqlite2.x86_64
	flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub io.gitlab.jstest_gtk.jstest_gtk
	cd ~
	mkdir Games
	cd Games
	wget https://launcher.mojang.com/download/Minecraft.tar.gz
	tar -xvf Minecraft.tar.gz
	rm Minecraft.tar.gz
}

gaming_apps