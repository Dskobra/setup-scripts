#!/usr/bin/bash

setup_servers(){
	sudo dnf install -y httpd mysql
}
setup_samba(){
	sudo dnf install -y samba
	sudo systemctl enable smb nmb
	sudo firewall-cmd --add-service=samba --permanent
	sudo firewall-cmd --reload
	sudo mkdir /mnt/backups
	sudo mkdir /mnt/projects
	sudo chown $USER /mnt/backups -R
	sudo chown $USER /mnt/projects -R
}

remote_tools(){
	sudo dnf install -y cockpit
	sudo systemctl enable --now cockpit.socket
	sudo firewall-cmd --add-service=cockpit
	sudo firewall-cmd --add-service=cockpit --permanent
}
setup_servers
setup_samba
remote_tools
