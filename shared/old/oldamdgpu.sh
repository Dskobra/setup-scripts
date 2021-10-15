#!/usr/bin/bash

amdgpu(){
	echo "Installing xorg amdgpu driver"
	sudo dnf install -y xorg-x11-drv-amdgpu
}

fan_setup(){
	# install base qt5 libraries
	sudo dnf install -y qt5-qtbase
	sudo dnf install -y qt5-qtcharts


	## install development files
	sudo dnf install -y qt5-qtbase-devel
	sudo dnf install -y qt5-qtcharts-devel
	sudo dnf install -y libXrandr-devel
	sudo dnf install -y libdrm-devel

	# clone radeon-profile and its daemon repositories
	cd ~
	git clone https://github.com/marazmista/radeon-profile-daemon
	git clone https://github.com/marazmista/radeon-profile

	# build the radeon-profile-daemon to run radeon-profile
	# without root
	cd radeon-profile-daemon
	cd radeon-profile-daemon
	qmake-qt5 && make

	# install and start the daemon
	sudo make install
	sudo systemctl enable radeon-profile-daemon.service
	sudo systemctl start radeon-profile-daemon.service

	cd ~
	cd radeon-profile
	cd radeon-profile
	qmake-qt5 && make

	# install the radeon-profile gui
	sudo make install

	# remove no longer needed libraries
	sudo dnf remove -y qt5-qtbase-devel
	sudo dnf remove -y libXrandr-devel
	sudo dnf remove -y libdrm-devel

	# remove directories
	cd ~
	rm -r -f radeon-profile-daemon
	rm -r -f radeon-profile
}

amdgpu
fan_setup
