#!/usr/bin/bash

dsksstuff_menu(){
    echo "------------------"
    echo "|   DSKs stuff   |"
    echo "------------------"
    echo ""
    echo "Stuff for myself. Feel free to use or not."
    echo ""
    echo ""
    echo ""
    echo "(1) Boot theme           (2) Game profiles"
    echo "(3) Autostart"
    echo "(0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)  
            install_spinfinity_theme
            dsksstuff_menu
            ;;

        2)
            game_profiles
            dsksstuff_menu
            ;;
        
        3)
            autostart
            dsksstuff_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            dsksstuff_menu
            ;;

        esac
        unset input
        dsksstuff_menu
}

game_profiles(){
    if test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        echo "MangoHud.conf exists. Not copying profiles over."
    elif ! test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        cd $SCRIPTS_HOME/data/game-profiles
        chown $USER:$USER *.conf
        cp *.conf $HOME/.config/MangoHud/
    fi
}

autostart(){
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    DROPBOX="/home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop"
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    DOVERLAY="/home/$USER/.local/share/flatpak/exports/share/applications/io.github.trigg.discover_overlay.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.CoreCtrl.desktop"

    [ -f $DROPBOX ] && { echo "Dropbox was found. Adding to startup."; cp "$DROPBOX"  /home/$USER/.config/autostart/com.dropbox.Client.desktop; }
    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $DOVERLAY ] && { echo "Discord Overlay was found. Adding to startup."; cp "$DOVERLAY"  /home/$USER/.config/autostart/io.github.trigg.discover_overlay.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.CoreCtrldesktop; }
}

install_spinfinity_theme(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y plymouth-theme-spinfinity
        sudo plymouth-set-default-theme spinfinity -R
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        check_for_spinfinity
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y plymouth-themes
        sudo plymouth-set-default-theme spinfinity -R
    else
        echo "Unkown error has occured."
    fi
}

check_for_spinfinity(){
    THEME="missing"
    test -d /usr/share/plymouth/themes/spinfinity/ && THEME="exists"
    if [ "$THEME" = "exists" ]
    then
        sudo plymouth-set-default-theme spinfinity -R
    elif [ "$THEME" = "missing" ]
    then
        sudo rpm-ostree install plymouth-theme-spinfinity
        SPINFINITY="Fedora Atomic editions will need to reboot first to load the package layer then rerun
        this option to apply the theme."
        zenity --warning --text="$SPINFINITY"
        check_if_fedora_immutable
    else
        echo "Unkown error has occured."
    fi
}