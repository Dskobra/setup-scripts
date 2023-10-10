#!/usr/bin/bash

fbasic(){
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y flathub org.keepassxc.KeePassXC
    flatpak install --user -y flathub com.dropbox.Client

}

fgames(){
    flatpak install --user -y flathub net.davidotek.pupgui2
    flatpak install --user -y flathub com.github.Matoking.protontricks
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08

    flatpak install --user -y flathub com.discordapp.Discord
    flatpak install --user -y flathub org.kde.kpat
    flatpak install --user -y flathub net.lutris.Lutris 
    
    # run once to ensure folders/runtimes are setup
    flatpak run net.lutris.Lutris
}

fmedia(){
    flatpak install --user -y flathub org.kde.kolourpaint
    flatpak install --user -y flathub org.videolan.VLC
    flatpak install --user -y flathub org.openshot.OpenShot
    flatpak install --user -y flathub com.obsproject.Studio

}

futils(){
    flatpak install --user -y flathub io.podman_desktop.PodmanDesktop
    flatpak install --user -y flathub org.kde.kleopatra
	flatpak install --user -y flathub org.gtkhash.gtkhash
    flatpak install --user -y flathub com.github.tchx84.Flatseal
}

fextras(){
    flatpak install --user -y flathub org.libreoffice.LibreOffice
	flatpak install --user -y flathub org.qownnotes.QOwnNotes
    flatpak install --user -y flathub com.transmissionbt.Transmission

    flatpak install --user -y flathub org.fedoraproject.MediaWriter
    flatpak install --user -y flathub org.kde.isoimagewriter
    flatpak install --user -y flathub org.raspberrypi.rpi-imager

}
