#!/usr/bin/bash

remote_tools(){
	sudo dnf install -y cockpit phpmyadmin
	sudo systemctl enable --now cockpit.socket
	sudo firewall-cmd --add-service=cockpit
	sudo firewall-cmd --add-service=cockpit --permanent
}

remote_tools
