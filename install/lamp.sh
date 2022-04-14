#!/usr/bin/bash

setup_servers(){
	sudo dnf install -y httpd php mariadb mariadb-server
	sudo dnf install -y phpmyadmin
	sudo systemctl enable --now httpd mariadb
}
setup_servers
