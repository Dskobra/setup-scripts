#!/usr/bin/bash

#github desktop for linux rpm package.
GDLINK=https://github.com/shiftkey/desktop/releases/download/release-2.9.4-linux1/GitHubDesktop-linux-2.9.4-linux1.rpm
GDBINARY=GitHubDesktop-linux-2.9.4-linux1.rpm

coding_tools(){
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
	source ~/.bashrc
	nvm install lts/*
	sudo dnf groupinstall -y "Development Tools"
	sudo dnf groupinstall -y "C Development Tools and Libraries"
	sudo dnf groupinstall -y "RPM Development Tools"
	sudo dnf install -y python3-tools python3-devel
	sudo dnf install -y java-11-openjdk-devel

}

github_desktop(){
	cd ~/Downloads
	wget $GDLINK
	sudo rpm -i $GDBINARY
	rm $GDBINARY
}

coding_tools
github_desktop