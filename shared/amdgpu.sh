#!/usr/bin/bash

amdgpu(){
	echo "Installing xorg amdgpu driver"
	sudo dnf install -y xorg-x11-drv-amdgpu
}

fan_setup(){
	sudo dnf install -y radeon-profile
	sudo systemctl enable radeon-profile-daemon.service
	sudo systemctl start radeon-profile-daemon.service
}

amdgpu
fan_setup
