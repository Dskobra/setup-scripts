#!/usr/bin/bash

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
setup_samba
