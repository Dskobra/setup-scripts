#!/usr/bin/bash

getHost=$(uname -n)
string=$(cat /proc/cpuinfo | grep 'model name' | uniq)
cpuInfo=$(echo "${string:13}")

determine_device(){
	if [ "$getHost" = "DESKTOP" ];
	then
		echo $cpuInfo
	elif [ "$getHost" = "LAPTOP" ];
	then
		echo $cpuInfo
	fi
}

determine_device
