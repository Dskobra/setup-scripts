#/usr/bin/bash

help(){
    echo "1. Lamp Stack - Apache web server, mariadb etc."
    echo "2. Fedora Cockpit - Setups fedora cockpit for remote management."
    echo "3. Samba Share - Installs samba server and creates folders."
}

menu(){
    echo "1. Lamp Stack 2. Samba Share"
    echo "3. Fedora Cockpit"
    echo "99. Help 0. Back to main menu"
    read input
    
    if [ $input -eq 1 ]
    then
        #./install/lamp.sh
        sudo dnf install -y httpd php mariadb mariadb-server
	    sudo dnf install -y phpmyadmin
	    sudo systemctl enable --now httpd mariadb
    elif [ $input -eq 2 ]
    then
        #./install/cockpit.sh
        sudo dnf install -y cockpit
	    sudo systemctl enable --now cockpit.socket
	    sudo firewall-cmd --add-service=cockpit
	    sudo firewall-cmd --add-service=cockpit --permanent
    elif [ $input -eq 3 ]
    then
        ./install/samba_share.sh
    elif [ $input -eq 99 ]
    then
        help
    elif [ $input -eq 0 ]
    then
	    exit
    else
	    echo "error."
    fi
    menu
}
menu