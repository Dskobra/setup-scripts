#!/usr/bin/bash

suse_menu(){
    echo "================================================"
    echo "openSUSE (tumbleweed)"
    echo "1. Setup DE 2. Gaming"
    echo "3. Dev Tools 4. Extras"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    case $input in

        1)
        install_basic_apps
        ;;

        2)
        install_game_clients
        source $SCRIPTS_HOME/modules/shared.sh; "game_profiles"
        ;;

        3)
        install_dev_tools
        ;;

        4)
        extras_menu
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
    suse_menu
}

install_basic_apps(){
	echo "Setting up packman essentials and brave browser"
    sudo zypper ar -cfp 90 https://ftp.fau.de/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials    # using essentials for ffmpeg etc
    sudo zypper dup -y --from packman-essentials --allow-vendor-change     # update system packages with essentials

    sudo zypper install curl
    sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
    sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

	sudo zypper install -y konsole kate ark discover dolphin-plugins \
    mozilla-openh264 gstreamer-plugin-openh264 p7zip-full java-17-openjdk\
    brave-browser plymouth-theme-spinfinity
       
	sudo plymouth-set-default-theme spinfinity -R

    pull_shared_code

    bash -c "source "$SCRIPTS_HOME"/modules/shared.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/shared.sh; futils"

}

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo zypper install -y steam goverlay gamescope gamemode
    sudo modprobe xpad


    source $SCRIPTS_HOME/modules/shared.sh; "fgames"
    source $SCRIPTS_HOME/modules/shared.sh; "wowup"
    source $SCRIPTS_HOME/modules/shared.sh; "minecraft"
    
}

install_dev_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/zypp/repos.d/vscodium.repo
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'

    sudo zypper install -y patterns-devel-C-C++-devel_C_C++ patterns-devel-python-devel_python3 patterns-devel-base-devel_rpm_build\
    patterns-containers-container_runtime
    sudo zypper install -y python310-idle git-gui java-17-openjdk-devel codium github-desktop distrobox


    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Virtualization 2. Corectrl"
    echo "3. Extra Apps 4. Cleanup"
    echo "5. Autostarts"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    case $input in

        1)
            echo "Use Yast -> "Virtualization" -> "Install Hypervisor and Tools" to install"
            ;;

        2)
            sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
            sudo zypper refresh
            sudo zypper install -y corectrl
            ;;
        3)
            sudo zypper install -y k3b v4l2loopback-autoload
            flatpak --user remote-add --if-not-exists kde-applications https://raw.githubusercontent.com/KDE/flatpak-kde-applications/master/kdeapps.flatpakrepo
            latpak --user install -y org.kde.xwaylandvideobridge
            cp /home/$USER/.local/share/flatpak/exports/share/applications/org.kde.xwaylandvideobridge.desktop /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop
            bash -c "source $SCRIPTS_HOME/modules/shared.sh; fmedia"
            bash -c "source $SCRIPTS_HOME/modules/shared.sh; fextras"
            ;;
        4)
            cleanup
            ;;

        5)
            autostart
            ;;

        
        9)
            suse_menu
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

autostart(){
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop
    DISCORD="/home/$USER/.local/share/flatpak/exports/share/applications/com.discordapp.Discord.desktop"
    STEAM="/usr/share/applications/steam.desktop"
    CORECTRL="/usr/share/applications/org.corectrl.corectrl.desktop"
    XWVIDEO_BRIDGE="/usr/share/applications/org.kde.xwaylandvideobridge.desktop"

    [ -f $DISCORD ] && { echo "Discord was found. Adding to startup."; cp "$DISCORD"  /home/$USER/.config/autostart/com.discordapp.Discord.desktop; }
    [ -f $STEAM ] && { echo "Steam was found. Adding to startup."; cp "$STEAM"  /home/$USER/.config/autostart/steam.desktop; }
    [ -f $CORECTRL ] && { echo "Corectrl was found. Adding to startup."; cp "$CORECTRL"  /home/$USER/.config/autostart/org.corectrl.corectrl.desktop; }
    [ -f $XWVIDEO_BRIDGE ] && { echo "XWaylandVideoBridge was found. Adding to startup."; cp "$XWVIDEO_BRIDGE"  /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop; }
}

cleanup(){
    sudo zypper remove -y icewm
}

pull_shared_code(){
    cd $SCRIPTS_HOME/temp
    git clone https://github.com/Dskobra/setup-scripts
    cd setup-scripts/modules
    chmod +x shared.sh
    mv shared.sh $SCRIPTS_HOME/modules
}

suse_menu
