#!/usr/bin/bash

server_apps(){
	sudo dnf install -y vim-enhanced lm_sensors
	sudo dnf install -y virt-manager libvirt-client
	sudo dnf install -y clamav clamav-update samba
}

setup_samba(){
	sudo systemctl enable smb nmb
	sudo firewall-cmd --add-service=samba --permanent
	sudo firewall-cmd --reload
	#sudo mkdir /mnt/sambashare
	#sudo chown jordan /mnt/sambashare -R
}

server_apps
setup_samba
