#!/usr/bin/bash

mystuff_menu(){
    echo "        -----------------------"
    echo "        |   My custom stuff   |"
    echo "        -----------------------"
    echo ""
    echo "Stuff for myself. Feel free to use or not."
    echo ""
    echo "                 Menu"
    echo ""
    echo "(1) Boot theme           (2) Game profiles"
    echo "(3) Autostart"
    echo "(m) Main Menu            (0) Exit"
    printf "Option: "
    read -r input

    case $input in


        1)  
            sudo $PKGMGR install -y plymouth-theme-spinfinity
            sudo plymouth-set-default-theme spinfinity -R
            mystuff_menu
            ;;

        2)
            game_profiles
            mystuff_menu
            ;;
        
        3)
            autostart
            mystuff_menu
            ;;
            
        m)
            source $SCRIPTS_HOME/modules/fedora/fedora.sh; "fedora_menu"
            ;;

        M)
            source $SCRIPTS_HOME/modules/fedora/fedora.sh; "fedora_menu"
            ;;

        0)
            source $SCRIPTS_HOME/modules/fedora/fedora.sh; "check_if_immutable"
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            mystuff_menu
            ;;

        esac
        unset input
        mystuff_menu
}

game_profiles(){
    if test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        echo "MangoHud.conf exists. Not copying profiles over."
    elif ! test -f /home/$USER/.config/MangoHud/MangoHud.conf; then
        cd $SCRIPTS_HOME/temp/
        git clone https://github.com/Dskobra/setup-scripts -b game-profiles

        mv setup-scripts game-profiles
        cd game-profiles
        dos2unix *.conf
        sudo chown $USER:$USER *.conf
        cp *.conf $HOME/.config/MangoHud/
    fi
}

autostart(){
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    DOVERLAY="/home/$USER/.local/share/flatpak/exports/share/applications/io.github.trigg.discover_overlay.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"

    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $DOVERLAY ] && { echo "Discord Overlay was found. Adding to startup."; cp "$DOVERLAY"  /home/$USER/.config/autostart/io.github.trigg.discover_overlay.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }
}