#!/usr/bin/bash

dev_menu(){
    echo "================================================"
    echo "Main Menu"
    echo "1. Virtual Machine (fedora) 2. Containers"
    echo "0. Exit"
    echo "================================================"
    printf "Option: "
    read -r input
    
    case $input in

        1)
        install_vm_basic_apps
        install_vm_dev_tools
        install_mugshot
        ;;

        2)
        container_dev_tools
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
    dev_menu
}

install_vm_basic_apps(){
	sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf update -y

    sudo dnf install -y xarchiver menulibre flatpak vim-enhanced\
    brave-browser plymouth-theme-spinfinity python3-distutils-extra     # distutils is needed for mugshot

    sudo dnf groupinstall -y "Firefox Web Browser"
    sudo dnf groupinstall -y "Extra plugins for the Xfce panel"
    
    sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
    sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg ffmpeg-libs.i686 ffmpeg-libs
	sudo plymouth-set-default-theme spinfinity -R
    
	bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; fbasic"
    bash -c "source $SCRIPTS_HOME/modules/flatpak.sh; futils"

    mkdir "$HOME"/.config/autostart # some desktops like mate dont have this created by default.


}

install_vm_dev_tools(){
	sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
	printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo
	sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
    
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"

	sudo dnf install -y python3-idle python3-devel git-gui \
	java-17-openjdk-devel codium github-desktop

    SCENE_BUILDER="SceneBuilder-20.0.0.rpm"
    curl -o $SCENE_BUILDER https://download2.gluonhq.com/scenebuilder/20.0.0/install/linux/SceneBuilder-20.0.0.rpm
    sudo rpm -i $SCENE_BUILDER

    ECLIPSE="eclipse-inst-jre-linux64.tar.gz"
    CURL -O $ECLIPSE https://eclipse.mirror.rafal.ca/oomph/epp/2023-09/R/eclipse-inst-jre-linux64.tar.gz

    tar -xvf $ECLIPSE
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
}

install_mugshot(){
    MUGSHOT_FOLDER="mugshot-0.4.3"
    cd $SCRIPTS_HOME/modules/
    curl -L -o $MUGSHOT_FOLDER.tar.gz https://github.com/bluesabre/mugshot/releases/download/mugshot-0.4.3/mugshot-0.4.3.tar.gz
    tar -xvf $MUGSHOT_FOLDER.tar.gz
    cd $MUGSHOT_FOLDER
    sudo python3 setup.py install
    sudo mkdir /usr/local/share/glib-2.0/schemas
    cd data/glib-2.0/schemas/
    sudo cp org.bluesabre.mugshot.gschema.xml  /usr/local/share/glib-2.0/schemas
    sudo glib-compile-schemas /usr/local/share/glib-2.0/schemas

}

container_dev_tools(){
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf groupinstall -y "C Development Tools and libraries"
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf groupinstall -y "RPM Development Tools"

    sudo dnf install -y python python3-devel java-17-openjdk-devel


    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	

}

dev_menu
