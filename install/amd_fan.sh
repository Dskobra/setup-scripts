#!/usr/bin/bash

fan_setup(){
	sudo dnf install -y radeon-profile
	sudo systemctl enable radeon-profile-daemon.service
	sudo systemctl start radeon-profile-daemon.service
}

fan_setup
