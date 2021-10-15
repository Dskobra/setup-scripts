#!/usr/bin/bash

controller_setup(){
	sudo dnf install -y kernel-modules-extra
	sudo modprobe xpad
}

controller_setup
