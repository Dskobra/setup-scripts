#!/usr/bin/bash

ossec_server(){
    sudo dnf install -y httpd php mariadb-server
    sudo dnf install -y phpmyadmin ossec-hids-server
    sudo systemctl enable --now httpd mariadb
}

ossec_server
