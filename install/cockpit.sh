#!/usr/bin/bash

install_cockpit(){
	sudo dnf install -y cockpit
	sudo systemctl enable --now cockpit.socket
	sudo firewall-cmd --add-service=cockpit
	sudo firewall-cmd --add-service=cockpit --permanent
}

install_cockpit
