#!/usr/bin/bash

install_spinfinity_theme(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y plymouth-theme-spinfinity
        sudo plymouth-set-default-theme spinfinity -R
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        check_for_spinfinity
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y plymouth-themes
        sudo plymouth-set-default-theme spinfinity -R
    else
        echo "Unkown error has occurred."
    fi
}

check_for_spinfinity(){
    THEME="missing"
    test -d "/usr/share/plymouth/themes/spinfinity/" && THEME="exists"
    if [ "$THEME" = "exists" ]
    then
        sudo plymouth-set-default-theme spinfinity -R
    elif [ "$THEME" = "missing" ]
    then
        sudo rpm-ostree install plymouth-theme-spinfinity
        SPINFINITY="Fedora Atomic editions will need to reboot first to load the package layer then rerun
        this option to apply the theme."
        zenity --warning --text="$SPINFINITY"
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    else
        echo "Unkown error has occurred."
    fi
}

install_spinfinity_theme
