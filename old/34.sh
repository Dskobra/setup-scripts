#!/usr/bin/bash

echo "Dsk Fedora setup script"

check_vm(){
	vmString=$(sudo dmidecode -s system-manufacturer)
	if [ "$vmString" = "QEMU" ]
	then
		echo "Running in a VM"
		./34/vm.sh
	elif [ "$vmString" != "QEMU" ]
	then
		echo "Not running in a VM"
		./34/nonvm.sh
	else
		echo "error"
		exit
	fi
}
check_vm
