#!/usr/bin/bash

fbasic(){
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.transmissionbt.Transmission
    flatpak install -y flathub com.dropbox.Client
}

fgames(){
    flatpak install -y flathub net.davidotek.pupgui2
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/21.08
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/22.08
    flatpak install -y flathub org.kde.kpat

    flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub net.lutris.Lutris 
    
    # run once to ensure folders/runtimes are setup
    flatpak run com.usebottles.bottles
    flatpak run net.lutris.Lutris
}

fextras(){
    flatpak install -y flathub org.openshot.OpenShot
    flatpak install -y flathub org.gimp.GIMP
    flatpak install -y flathub org.kde.kolourpaint
    flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub im.pidgin.Pidgin
    flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y flathub org.qownnotes.QOwnNotes

    flatpak install -y flathub org.fedoraproject.MediaWriter
    flatpak install -y flathub org.kde.kleopatra
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install -y flathub org.raspberrypi.rpi-imager
    flatpak install -y flathub org.videolan.VLC
    flatpak install -y flathub com.obsproject.Studio
}