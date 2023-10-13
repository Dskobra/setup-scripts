#!/usr/bin/bash

fedora_ostree_menu(){
    echo "================================================"
    echo "Fedora (ostree)"
    echo "1. Setup Repos 2. Setup DE"
    echo "3. Gaming 4. Dev Tools"
    echo "5. Extras 6. Upgrade"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    case $input in

        1)
            sudo rpm-ostree refresh-md
            sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
            confirm_reboot
            ;;

        2)
            sudo rpm-ostree refresh-md
            install_basic_apps
            confirm_reboot
            ;;

        3)
            sudo rpm-ostree refresh-md
            install_game_clients
            $SCRIPTS_HOME/modules/game_profiles.sh
            confirm_reboot
            ;;

        4)
            sudo rpm-ostree refresh-md
            install_dev_tools
            confirm_reboot
            ;;

        5)
            extras_menu
            ;;

        6)
            upgrade_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        fedora_ostree_menu
        ;;

    esac
    unset input
    fedora_ostree_menu
}

install_basic_apps(){
	sudo rpm-ostree install -y kate vim-enhanced \
    lm_sensors java-17-openjdk dos2unix

    sudo rpm-ostree override remove libavcodec-free libavfilter-free \
    libavformat-free libavutil-free libpostproc-free \
    libswresample-free libswscale-free --install ffmpeg
    sudo rpm-ostree install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg-libs.i686

    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; futils"
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    
    cd "$HOME"/Downloads
    curl -o brave-core.asc https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo mv brave-core.asc /etc/pki/rpm-gpg/brave-core.asc

    curl -o brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    sudo mv brave-browser.repo /etc/yum.repos.d/brave-browser.repo
    sudo rpm-ostree install brave-browser
    sudo rpm-ostree install gwenview    # installing separate as if package is present none of the other packages install
}

install_game_clients(){
    mkdir "$HOME"/Games
    mkdir "$HOME"/.config/MangoHud/
    sudo rpm-ostree install -y steam goverlay gamescope

    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fgames"
    bash -c "source $SCRIPTS_HOME/modules/misc.sh; wowup"
    bash -c "source $SCRIPTS_HOME/modules/misc.sh; minecraft"
    
}

install_dev_tools(){
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
	sudo rpm-ostree install codium git-gui github-desktop distrobox
}

extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Virtualization 2. Corectrl"
    echo "3. Extra Apps 4. Post install"
    echo "9. Main Menu 0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
            sudo rpm-ostree refresh-md
	        sudo rpm-ostree install virt-manager 
            confirm_reboot
            ;;

        2)
            sudo rpm-ostree refresh-md
            sudo rpm-ostree install corectrl
            confirm_reboot
            ;;

        3)
            sudo rpm-ostree refresh-md
            sudo rpm-ostree install k3b v4l2loopback
            sudo rpm-ostree install okular # installing separate as if package is present none of the other packages installed
            sudo rpm-ostree install xwaylandvideobridge
            bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fmedia"
            bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fextras"
            confirm_reboot
            ;;

        4)
            post_install
            ;;

        9)
            fedora_ostree_menu
            ;;

        0)
            exit
            ;;

    *)
        echo -n "Unknown entry"
        echo ""
        extras_menu
    
    esac
    unset input
    extras_menu
}

post_install(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Corectrl 2. Setup xpad"
    echo "3. Setup autostart apps"
    echo "0. Back"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
            cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
            ;;

        2)
            sudo modprobe xpad
            ;;

        3)
            autostart
            ;;

        9)
            fedora_ostree_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            post_install

    
    esac
    unset input
    post_install
}

autostart(){
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"
    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }

}

upgrade_menu(){
    echo "================================================"
    echo "Upgrade Steps"
    echo "1. Wipe layers/overrides 2. Upgrade"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
            sudo rpm-ostree reset
            sudo sytemctl reboot
            ;;

        2)
            sudo ostree admin pin 0
            sudo  rpm-ostree rebase fedora:fedora/39/x86_64/kinoite
            sudo systemctl reboot
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            upgrade_menu
            ;;

    esac
    unset input
}

confirm_reboot(){
    echo "================================================"
    echo "Reboots are required to enable the new layers."
    echo "Do you wish to reboot now?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to reboot."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    menu
    fi
}

fedora_ostree_menu
