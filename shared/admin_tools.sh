#!/usr/bin/bash

admin_tools(){
	sudo dnf install -y cockpit
	sudo systemctl enable --now cockpit.socket
	sudo firewall-cmd --add-service=cockpit
	sudo firewall-cmd --add-service=cockpit --permanent
}

admin_tools
