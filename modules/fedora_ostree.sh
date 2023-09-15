#!/usr/bin/bash

fedora_ostree_menu(){
    echo "================================================"
    echo "Fedora (ostree)"
    echo "1. Setup Repos 2. Setup DE"
    echo "3. Gaming 4. Dev Tools"
    echo "5. Extras"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        confirm_reboot
    elif [ "$input" -eq 2 ]
    then
        install_basic_apps
        confirm_reboot
    elif [ "$input" -eq 3 ]
    then
        install_game_clients
        mango
        confirm_reboot
    elif [ "$input" -eq 4 ]
    then
        install_dev_tools
        confirm_reboot
    elif [ "$input" -eq 5 ]
    then
        extras_menu
    elif [ "$input" -eq 0 ]
    then
        killall -9 setup.sh
        echo "Killed launch script. Exiting will now completely exit."
	    exit
    else
	    echo "error."
    fi
    unset input
    fedora_ostree_menu
}

install_basic_apps(){
	echo "Setting up rpmfusion."

	sudo rpm-ostree install -y java-17-openjdk vim-enhanced \
    lm_sensors kate-plugins p7zip dos2unix

    sudo rpm-ostree override remove libavcodec-free libavfilter-free \
    libavformat-free libavutil-free libpostproc-free \
    libswresample-free libswscale-free --install ffmpeg
    sudo rpm-ostree install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg-libs.i686

    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; futils"
    flatpak install --user -y flathub com.brave.Browser
    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.
    toolbox create -y coding-apps
}

install_game_clients(){
    mkdir "$HOME"/Games
    mkdir "$HOME"/.config/MangoHud/
    sudo rpm-ostree install -y goverlay steam

    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fgames"
    bash -c "source $SCRIPTS_HOME/modules/misc.sh; extra_games"
    
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
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
	    sudo rpm-ostree install virt-manager 
        confirm_reboot
    elif [ "$input" -eq 2 ]
    then
        sudo rpm-ostree install corectrl
        confirm_reboot
    elif [ "$input" -eq 3 ]
    then
        sudo rpm-ostree install k3b v4l2loopback
        bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fmedia"
        bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fextras"
        confirm_reboot
    elif [ "$input" -eq 4 ]
    then
        post_install
    elif [ "$input" -eq 0 ]
    then
	    fedora_ostree_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    extras_menu
}

mango(){
    # link lutris to mangohud configuration folder
    ln -s "$HOME/.config/MangoHud/" "$HOME/.var/app/net.lutris.Lutris/config/"
    $SCRIPTS_HOME/modules/mangohud.sh
}

post_install(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Corectrl 2. Setup xpad"
    echo "0. Back"
    echo "================================================"
    printf "Option: "
    read -r input
    
    if [ "$input" -eq 1 ]
    then
        cp /usr/share/applications/org.corectrl.corectrl.desktop "$HOME"/.config/autostart/org.corectrl.corectrl.desktop
    elif [ "$input" -eq 0 ]
    then
	    fedora_ostree_menu
    else
	    echo "error."
    fi
    echo $input
    unset input
    post_install
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
