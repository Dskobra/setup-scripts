	#!/usr/bin/bash

ossec(){
    OSSECLINK=https://github.com/ossec/ossec-hids/archive/3.7.0.tar.gz
	OSSECTARBALL=3.7.0.tar.gz
    sudo dnf install -y zlib-devel pcre2-devel make gcc sqlite-devel openssl-devel libevent-devel systemd-devel
	cd /home/$USER/Downloads/
    wget $OSSECLINK
    tar -xvf $OSSECTARBALL
    cd ossec-hids*
    sudo ./install.sh
}
ossec