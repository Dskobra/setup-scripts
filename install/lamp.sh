#!/usr/bin/bash

install_lamp(){
	sudo dnf install -y httpd php mariadb mariadb-server
	sudo dnf install -y phpmyadmin
	sudo systemctl enable --now httpd mariadb
}
install_lamp
