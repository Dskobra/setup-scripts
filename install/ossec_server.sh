#!/usr/bin/bash

PHPMYADMINLINK=https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.zip
PHPMYADMINBINARY=phpMyAdmin-5.1.1-all-languages.zip
PHPMYADMINDIR=phpMyAdmin-5.1.1-all-languages

desktop_setup(){
    sudo dnf groupinstall -y "Standard" "Guest Agents"
    sudo dnf groupinstall -y "Workstation"
    sudo systemctl set-default graphical.target
}
setup_servers(){
    sudo dnf install @httpd
	sudo dnf install -y php-xml php-json mariadb-server 
    sudo dnf install -y php-mysqlnd
    sudo systemctl enable --now httpd mariadb
}
setup_phpmyadmin(){
    #download and setup phpmyadmin
    cd /home/$USER/Downloads
    wget $PHPMYADMINLINK
    unzip $PHPMYADMINBINARY
    rm $PHPMYADMINBINARY
    sudo mv $PHPMYADMINDIR /usr/share/phpmyadmin
    sudo cp /usr/share/phpmyadmin/config.sample.inc.php  /usr/share/phpmyadmin/config.inc.php
    sudo mkdir /usr/share/phpmyadmin/tmp

    #setup phpmyadmin folder permissions and firewall
    sudo chown -R apache:apache /usr/share/phpmyadmin
    sudo chmod 777 /usr/share/phpmyadmin/tmp
    
    sudo firewall–cmd ––permanent ––add-service=http
    sudo firewall-cmd ––reload

    #make sure selinux tools are installed and force a relabel
    sudo dnf install -y policycoreutils-python-utils
    cd /
    sudo touch .autorelabel
}

setup_epel(){
    sudo dnf config-manager --set-enabled powertools
    sudo dnf install epel-release epel-next-release
}

ossec_server(){
    wget -q -O - https://updates.atomicorp.com/installers/atomic | sudo bash
    sudo dnf install -y ossec-hids-server
}
remote_tools(){
	sudo dnf install -y cockpit phpmyadmin
	sudo systemctl enable --now cockpit.socket
	sudo firewall-cmd --add-service=cockpit
	sudo firewall-cmd --add-service=cockpit --permanent
}

desktop_setup
setup_servers
setup_phpmyadmin
ossec_server
remote_tools
