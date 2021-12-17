#!/usr/bin/bash

razer(){
	sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/hardware:razer/Fedora_34/hardware:razer.repo
	sudo dnf install -y kernel-devel \
	openrazer-meta razergenie
	sudo gpasswd -a jordan plugdev
}

razer
