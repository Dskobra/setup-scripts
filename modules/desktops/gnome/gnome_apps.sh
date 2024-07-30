#! /usr/bin/bash

install_gnome_apps(){
    echo "-------Pick an option-------"
    echo "(1) distro built app"
    echo "(2) distro neutral flatpak"
    echo "(3) for help"
    echo "(empty) default option which is flatpak"
    echo "----------------------------"
    printf "Option: "
    read -r input
    if [ "$input" = 1 ]
    then
        packages_gnome
    elif [ "$input" = 2 ] || [ -z "$input" ]
    then
        remove_core_gnomeapps
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
    elif [ "$input" = 3 ]
    then
        $SCRIPTS_FOLDER/modules/core/packages_help_page.sh
    else
        echo "Invalid option"
    fi
}

packages_gnome(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y file-roller evince dconf-editor pavucontrol cheese\
        gnome-extensions-app
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree file-roller evince dconf-editor pavucontrol cheese\
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

remove_core_gnomeapps(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y file-roller evince dconf-editor pavucontrol cheese\
        gnome-extensions-app
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        remove_silverblue_flatpaks
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y file-roller evince dconf-editor pavucontrol cheese\
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


install_gnome_apps