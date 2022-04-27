#!/usr/bin/bash

coding_tools(){

	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf groupinstall -y "Development Tools"
	sudo dnf groupinstall -y "C Development Tools and Libraries"
	sudo dnf groupinstall -y "RPM Development Tools"
	sudo dnf install -y python3-tools python3-devel
	sudo dnf install -y java-17-openjdk-devel

}

old_github_desktop(){
	GITHUBLINK=https://github.com/shiftkey/desktop/releases/download/release-2.9.6-linux1/GitHubDesktop-linux-2.9.6-linux1.rpm
	GITHUBBINARY=GitHubDesktop-linux-2.9.6-linux1.rpm
	cd /home/$USER/Downloads
	wget $GITHUBLINK
	sudo rpm -i $GITHUBBINARY
	rm $GITHUBBINARY
}
github_desktop(){
	flatpak install -y flathub io.github.shiftey.Desktop	#changed to flathub version of github desktop.
}
coding_tools
github_desktop