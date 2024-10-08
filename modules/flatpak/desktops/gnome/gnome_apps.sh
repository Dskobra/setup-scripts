#! /usr/bin/bash

remove_core_gnome_apps(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y evince dconf-editor pavucontrol cheese\
        gnome-extensions-app
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        remove_silverblue_flatpaks
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y evince dconf-editor pavucontrol cheese\
        gnome-shell-extension-prefs 
    else
        echo "Unkown error has occurred."
    fi
}

remove_silverblue_flatpaks(){
    flatpak remove -y org.fedoraproject.MediaWriter
    flatpak remove -y org.fedoraproject.Platform
    flatpak remove -y org.gnome.Calculator
    flatpak remove -y org.gnome.Calendar
    flatpak remove -y org.gnome.Characters
    flatpak remove -y org.gnome.Connections
    flatpak remove -y org.gnome.Contacts
    flatpak remove -y org.gnome.Evince
    flatpak remove -y org.gnome.Extensions
    flatpak remove -y org.gnome.Logs 
    flatpak remove -y org.gnome.Loupe
    flatpak remove -y org.gnome.Maps 
    flatpak remove -y org.gnome.Snapshot
    flatpak remove -y org.gnome.TextEditor
    flatpak remove -y org.gnome.Weather 
    flatpak remove -y org.gnome.baobab
    flatpak remove -y org.gnome.clocks
    flatpak remove -y org.gnome.font-viewer
}

remove_core_gnome_apps
flatpak install --user -y flathub org.gnome.clocks
flatpak install --user -y flathub org.gnome.Calendar
flatpak install --user -y flathub org.gnome.Weather
flatpak install --user -y flathub org.gnome.Contacts
flatpak install --user -y flathub org.gnome.Calculator
flatpak install --user -y flathub org.gnome.TextEditor
flatpak install --user -y flathub org.gnome.Extensions
flatpak install --user -y flathub org.gnome.Connections
flatpak install --user -y flathub org.gnome.Characters
flatpak install --user -y flathub org.gnome.font-viewer
flatpak install --user -y flathub org.gnome.Evince
flatpak install --user -y flathub org.gnome.Loupe
flatpak install --user -y flathub org.gnome.Maps
flatpak install --user -y flathub org.gnome.Snapshot
flatpak install --user -y flathub org.gnome.FileRoller
flatpak install --user -y flathub org.pulseaudio.pavucontrol
flatpak install --user -y flathub ca.desrt.dconf-editor
flatpak install --user -y flathub org.gnome.Logs
flatpak install --user -y flathub org.gnome.baobab
