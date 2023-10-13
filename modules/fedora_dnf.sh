#!/usr/bin/bash

fedora_dnf_menu(){
    echo "================================================"
    echo "Fedora (dnf)"
    echo "1. Setup DE 2. Gaming"
    echo "3. Dev Tools 4. Extras"
    echo "5. Upgrade"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
            install_basic_apps
            fedora_dnf_menu
            ;;

        2)
            install_game_clients
            $SCRIPTS_HOME/modules/game_profiles.sh
            fedora_dnf_menu
            ;;

        3)
            install_dev_tools
            fedora_dnf_menu
            ;;

        4)
            extras_menu
            ;;

        5)
            upgrade_menu
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            fedora_dnf_menu
            ;;

        esac
        unset input
        fedora_dnf_menu
}

install_basic_apps(){
    echo "Setting up rpmfusion and brave browser"
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y


	sudo dnf install -y  ark gwenview kate vim-enhanced java-17-openjdk \
    brave-browser plymouth-theme-spinfinity lm_sensors dnfdragora git # git is needed to pull from my game-profiles branch.        
    
    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
	sudo plymouth-set-default-theme spinfinity -R
    
	bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; futils"

}

install_game_clients(){
    mkdir "$HOME"/Games
    mkdir "$HOME"/.config/MangoHud/
    sudo dnf install -y steam goverlay gamescope
    sudo modprobe xpad

    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fgames"
    bash -c "source $SCRIPTS_HOME/modules/misc.sh; wowup"
    bash -c "source $SCRIPTS_HOME/modules/misc.sh; minecraft"
}

install_dev_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'

	sudo dnf install -y codium git-gui github-desktop\
    toolbox distrobox 
    sudo systemctl enable podman
}

extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Virtualization 2. Corectrl"
    echo "3. Extra Apps 4. Cleanup"
    echo "9. Main Menu 0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    case $input in

        1)
            sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
            -O /etc/yum.repos.d/virtio-win.repo
            sudo dnf groupinstall -y "Virtualization"
            sudo dnf install -y virtio-win
            ;;

        2)
            sudo dnf install -y corectrl
            ;;
        3)
            sudo dnf install -y okular k3b v4l2loopback xwaylandvideobridge # needed for video sharing with discord on wayland without obs etc
            cp /usr/share/applications/org.kde.xwaylandvideobridge.desktop /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop
            bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fmedia"
            bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fextras"
            ;;
        4)
            cleanup
            autostart
            ;;

        
        9)
            fedora_dnf_menu
            ;;
        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            extras_menu
            ;;

        esac
        unset input
        extras_menu
}

upgrade_menu(){
    echo "================================================"
    echo "Upgrade Steps"
    echo "1. Remove RPMFusion 2. Upgrade"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input

    case $input in

        1)
            confirm_removal
            ;;

        2)
            sudo dnf upgrade --refresh
            sudo dnf install dnf-plugin-system-upgrade
            sudo dnf system-upgrade download --releasever=39
            sudo dnf system-upgrade reboot
            ;;

        0)
            exit
            ;;

        *)
            echo -n "Unknown entry"
            echo ""
            launch_menu
            ;;
            
        esac
        unset input
}

confirm_removal(){
    echo "================================================"
    echo "This will remove RPMFusion and packages from"
    echo "there including steam and swap back to the"
    echo "fedora provided ffmpeg. This ensures the" 
    echo "upgrade goes smoothly. Any settings,"
    echo "appimages and steam games should remain."
    echo "Are you sure you wish to remove them?"
    echo "Type y/n or exit"
    echo "================================================"
    printf "Option: "
    read input
    
    if [ $input == "y" ] || [ $input == "Y" ]
    then
        sudo dnf remove -y steam steam-devices
        sudo dnf swap -y ffmpeg ffmpeg-free --allowerasing
        sudo dnf remove -y rpmfusion-free-release rpmfusion-nonfree-release
        sudo dnf clean all
        sudo dnf update -y
        sudo systemctl reboot
    elif [ $input == "n" ] || [ $input == "N" ]
    then
        echo "Chose not to remove."
    elif [ $input == "exit" ]
    then
	    exit
    else
	    upgrade_menu
    fi
}

autostart(){
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"
    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }
}

cleanup(){
	# Installing Fedora 36 using the everything installer to install the mate desktop with my normal package groups "Development Tools", 
	# "C Development Tools and libraries" and "RPM Development Tools" results in systemd-oomd-defaults also being installed.
	# This creates a package conflict with mate-desktop and mate-desktop-configs when updating. Research shows this is an 
	# uneeded/extra package as Fedora uses earlyoom. So removing systemd-oomd-defaults is perfectly safe. Unsure what causes this
	# to be installed.
	sudo dnf remove -y libreoffice-core \
	gnome-shell-extension-gamemode gnome-text-editor \
	kmahjongg kmines systemd-oomd-defaults \
	transmission-gtk transmission-qt \
	compiz kpat
}

fedora_dnf_menu
