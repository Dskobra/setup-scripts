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
        $SCRIPTS_HOME/modules/game_profiles.sh 
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

	sudo zypper install -y konsole kate ark discover dolphin-plugins\
	plymouth-theme-spinfinity 7zip hplip java-17-openjdk brave-browser\
    mozilla-openh264 gstreamer-plugin-openh264 
       
	sudo plymouth-set-default-theme spinfinity -R

    bash -c "source "$SCRIPTS_HOME"/modules/flatpak.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; futils"

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    cp /home/$USER/.local/share/flatpak/exports/share/applications/com.dropbox.Client.desktop /home/$USER/.config/autostart/com.dropbox.Client.desktop


}

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo zypper install -y steam goverlay gamescope gamemode
    sudo modprobe xpad

    bash -c "source "$SCRIPTS_HOME"/modules/flatpak.sh; fgames"
    bash -c "source "$SCRIPTS_HOME"/modules/misc.sh; extra_games"
    
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
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        echo "Use Yast -> "Virtualization" -> "Install Hypervisor and Tools" to install"
    elif [ "$input" -eq 2 ]
    then
        sudo zypper addrepo https://download.opensuse.org/repositories/home:Dead_Mozay/openSUSE_Tumbleweed/home:Dead_Mozay.repo
        sudo zypper refresh
        sudo zypper install -y corectrl
	    cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
    elif [ "$input" -eq 3 ]
    then
        sudo zypper install -y k3b v4l2loopback-autoload
        flatpak --user remote-add --if-not-exists kde-applications https://raw.githubusercontent.com/KDE/flatpak-kde-applications/master/kdeapps.flatpakrepo
        flatpak --user install -y org.kde.xwaylandvideobridge
        cp /home/$USER/.local/share/flatpak/exports/share/applications/org.kde.xwaylandvideobridge.desktop /home/$USER/.config/autostart/org.kde.xwaylandvideobridge.desktop
        bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fmedia"
        bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fextras"
    elif [ "$input" -eq 4 ]
    then
        cleanup
    elif [ "$input" -eq 0 ]
    then
	    suse_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    extras_menu
}

cleanup(){
    sudo zypper remove -y icewm
}

suse_menu
