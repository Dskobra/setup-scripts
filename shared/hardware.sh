#!/usr/bin/bash

hardware(){
	sudo dnf install -y dkms hplip-gui lm_sensors
}

hardware
