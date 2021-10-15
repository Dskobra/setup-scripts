#!/usr/bin/bash

security_apps(){
	wget https://updates.atomicorp.com/channels/atomic/fedora/33/x86_64/RPMS/atomic-release-1.0-22.fc33.art.noarch.rpm
	sudo rpm -i atomic-release*.rpm
	sudo dnf install -y clamav clamav-update ossec-hids-agent
}

security_apps
