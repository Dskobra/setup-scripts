#!/usr/bin/bash

coding_tools(){
	sudo rpm --import https://packagecloud.io/shiftkey/desktop/gpgkey
	sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/shiftkey/desktop/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf groupinstall -y "Development Tools"
	sudo dnf groupinstall -y "C Development Tools and Libraries"
	sudo dnf groupinstall -y "RPM Development Tools"
	sudo dnf install -y python3-tools python3-devel github-desktop
	sudo dnf install -y java-17-openjdk-devel

}

coding_tools