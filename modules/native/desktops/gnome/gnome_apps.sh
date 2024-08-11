#! /usr/bin/bash

packages_gnome(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y file-roller evince dconf-editor pavucontrol cheese\
        gnome-extensions-app
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install file-roller evince dconf-editor pavucontrol cheese\
        gnome-extensions-app
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y file-roller evince dconf-editor pavucontrol cheese\
        gnome-shell-extension-prefs 
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y  org.gnome.clocks
flatpak remove --user -y  org.gnome.Calendar
flatpak remove --user -y  org.gnome.Weather
flatpak remove --user -y  org.gnome.Contacts
flatpak remove --user -y  org.gnome.Calculator
flatpak remove --user -y  org.gnome.TextEditor
flatpak remove --user -y  org.gnome.Extensions
flatpak remove --user -y  org.gnome.Connections
flatpak remove --user -y  org.gnome.Characters
flatpak remove --user -y  org.gnome.font-viewer
flatpak remove --user -y  org.gnome.Evince
flatpak remove --user -y  org.gnome.Loupe
flatpak remove --user -y  org.gnome.Maps
flatpak remove --user -y  org.gnome.Snapshot
flatpak remove --user -y  org.gnome.FileRoller
flatpak remove --user -y  org.pulseaudio.pavucontrol
flatpak remove --user -y  ca.desrt.dconf-editor
flatpak remove --user -y  org.gnome.Logs
flatpak remove --user -y  org.gnome.baobab
packages_gnome