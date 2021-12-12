#!/usr/bin/bash

nvidia(){
	echo "Installing latest rpmfusion akmod-nvidia and nvidia-settings packages."
	sudo dnf install -y akmod-nvidia nvidia-settings
}

nvidia
