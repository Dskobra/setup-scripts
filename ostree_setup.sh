#!/usr/bin/bash

main_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Setup Repos 2. Setup DE"
    echo "3. Gaming 4. Coding Tools"
    echo "5. Extras"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        ask_for_reboot # rpmfusion line is long and i dont feel like scrolling to add a pipe
    elif [ "$input" -eq 2 ]
    then
        install_basic_apps
        check_for_reboot
    elif [ "$input" -eq 3 ]
    then
        install_game_clients
        check_for_reboot
    elif [ "$input" -eq 4 ]
    then
        install_coding_tools
        check_for_reboot
    elif [ "$input" -eq 5 ]
    then
        extras_menu
    elif [ "$input" -eq 100 ]
    then
        about
    elif [ "$input" -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    echo $input
    unset input
    main_menu
}

extras_menu(){
    echo "================================================"
    echo "Extras"
    echo "1. Virtualization 2. Corectrl"
    echo "3. Extra Apps 4. Post install"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
	    sudo rpm-ostree install virt-manager
        check_for_reboot
    elif [ "$input" -eq 2 ]
    then
        sudo rpm-ostree install corectrl
        check_for_reboot
    elif [ "$input" -eq 3 ]
    then
        extra_apps
        check_for_reboot
    elif [ "$input" -eq 4 ]
    then
        post_install
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    extras_menu
}

extra_apps(){
    
    sudo rpm-ostree install k3b v4l2loopback
    
    flatpak install -y flathub org.openshot.OpenShot
    flatpak install -y flathub org.gimp.GIMP
    flatpak install -y flathub org.kde.kolourpaint
    flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub im.pidgin.Pidgin
    flatpak install -y flathub org.libreoffice.LibreOffice
	flatpak install -y flathub org.qownnotes.QOwnNotes

    flatpak install -y flathub org.fedoraproject.MediaWriter
    flatpak install -y flathub org.kde.kleopatra
	flatpak install -y flathub org.gtkhash.gtkhash
	flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install -y flathub org.raspberrypi.rpi-imager
    flatpak install -y flathub org.videolan.VLC
    flatpak install -y flathub com.obsproject.Studio
    flatpak install -y flathub org.soundconverter.SoundConverter

}

install_basic_apps(){
	echo "Setting up rpmfusion and flathub."
    flatpak remote-modify --disable fedora
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	sudo rpm-ostree install -y java-17-openjdk vim-enhanced \
    kate-plugins p7zip >> ostree.txt

    sudo rpm-ostree override remove libavcodec-free libavfilter-free \
    libavformat-free libavutil-free libpostproc-free \
    libswresample-free libswscale-free --install ffmpeg
    sudo rpm-ostree install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg-libs.i686 


    flatpak install -y flathub io.podman_desktop.PodmanDesktop
	flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.transmissionbt.Transmission
    flatpak install -y flathub com.dropbox.Client
    flatpak install -y flathub com.brave.Browser
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    toolbox create -y coding-apps
}

install_game_clients(){
    mkdir "$HOME"/Games
	mkdir "$HOME"/Games/bottles
    mkdir "$HOME"/.config/MangoHud/
    sudo rpm-ostree install -y mangohud steam >> ostree.txt

    flatpak install -y flathub net.davidotek.pupgui2
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/21.08
    flatpak install -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/22.08

    flatpak install -y flathub com.usebottles.bottles
    flatpak install -y flathub net.lutris.Lutris 
    
    # run once to ensure folders/runtimes are setup
    flatpak run com.usebottles.bottles
    flatpak run net.lutris.Lutris

    cd "$HOME"/Downloads
    wget https://launcher.mojang.com/download/Minecraft.tar.gz
    tar -xvf Minecraft.tar.gz
    cd minecraft-launcher
    chmod +x minecraft-launcher
    mv minecraft-launcher "$HOME"/Desktop
    cd "$HOME"/Downloads
    rm -r minecraft-launcher
    rm Minecraft.tar.gz

    flatpak install -y flathub org.kde.kpat

    WOWUPLINK=https://github.com/WowUp/WowUp.CF/releases/download/v2.9.4-beta.2/WowUp-CF-2.9.4-beta.2.AppImage
    WOWUPBINARY=WowUp-CF-2.9.4-beta.2.AppImage
    cd "$HOME"/Desktop
    wget $WOWUPLINK
    chmod +x $WOWUPBINARY
    
}

coding_servers_menu(){
    echo "================================================"
    echo "Coding and Servers"
    echo "1. Coding Tools"
    echo "0. Back to main menu"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        install_coding_tools
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    coding_servers_menu
}

install_coding_tools(){
    echo "Currently only installs a small subset of tools."
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
	sudo rpm-ostree install codium github-desktop >> ostree.txt

}

mango(){
    # link bottles/lutris to mangohud configuration folder
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/com.usebottles.bottles/config/"
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
    USER=$(whoami)
    cd $SCRIPTS_HOME/mangohud
    sudo chown $USER:$USER *.conf
    cp wine-GTA5.conf $HOME/.config/MangoHud/
    cp wine-NewWorld.conf $HOME/.config/MangoHud/
    cp wine-PathOfExile_x64Steam.conf $HOME/.config/MangoHud/
    cp wine-R5Apex.conf $HOME/.config/MangoHud/
    cp wine-RuneScape.conf $HOME/.config/MangoHud/
    cp wine-WorldOfTanks.conf $HOME/.config/MangoHud/
    cp wine-WorldOfWarships.conf $HOME/.config/MangoHud/
    cp wine-Gw2-64.conf $HOME/.config/MangoHud/
    cp wine-WoW.conf $HOME/.config/MangoHud/
    cp "wine-Diablo IV.conf" $HOME/.config/MangoHud/
    
}

setup_deck(){
    flatpak install -y flathub org.mozilla.firefox
    flatpak install -y flathub com.brave.Browser
    flatpak install -y flathub com.dropbox.Client
    flatpak install -y flathub org.keepassxc.KeePassXC
    flatpak install -y flathub com.discordapp.Discord
    flatpak install -y flathub net.davidotek.pupgui2
    flatpak install -y flathub net.lutris.Lutris
    flatpak install -y flathub com.github.tchx84.Flatseal
    flatpak install -y flathub org.kde.kpat
}

post_install(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Corectrl 2. Setup xpad"
    echo "3. MangoHud Profiles"
    echo "0. Back"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
    elif [ "$input" -eq 2 ]
    then
        sudo modprobe xpad
    elif [ "$input" -eq 3 ]
    then
        mango
    elif [ "$input" -eq 0 ]
    then
	    main_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    post_install
}

check_for_reboot(){
    RESTART_TEST=$(grep -F 'Added:' ostree.txt)
    if [ "$RESTART_TEST" = 'Added:' ]
    then
        echo "Restart needed."
        ask_for_reboot
    else
        echo "No restart needed."
        exit
    fi
}

ask_for_reboot(){
    rm ostree.txt
    echo "================================================"
    echo "System has requested a reboot."
    echo "Type Y/N to confirm or decline"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" == "Y" ] || [ "$input" == "y" ]
    then
        sudo systemctl reboot
    elif [ "$input" == "N"] || [ "$input" == "n" ]
    then
        echo "Reboot declined"
	    exit
    else
	    echo "error."
    fi
    ask_for_reboot
}

SCRIPTS_HOME=$(pwd)
main_menu
