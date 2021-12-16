#!/usr/bin/bash

USER=$(whoami)

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
setup_servers
setup_samba
