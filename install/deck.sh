#! /usr/bin/bash

sudo pacman -S flatpak kate dolphin-plugins
sudo pacman -R firefox
flatpak install -y flathub net.davidotek.pupgui2
flatpak install -y flathub org.mozilla.firefox
flatpak install -y flathub com.dropbox.Client
flatpak install -y flathub org.keepassxc.KeePassXC
flatpak install -y flathub com.discordapp.Discord
flatpak install flathub org.gnome.Platform.Compat.i386 org.freedesktop.Platform.GL32.default org.freedesktop.Platform.GL.default