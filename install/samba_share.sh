#!/usr/bin/bash

setup_samba(){
	sudo dnf install -y samba
	sudo systemctl enable smb nmb
	sudo firewall-cmd --add-service=samba --permanent
	sudo firewall-cmd --reload
	sudo mkdir /mnt/shared
	sudo chown $USER /mnt/shared -R
}
setup_samba
