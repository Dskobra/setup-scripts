#!/usr/bin/bash

echo "Dsk Fedora setup script"

check_vm(){
	vmString=$(sudo dmidecode -s system-manufacturer)
	if [ "$vmString" = "QEMU" ]
	then
		echo "VM Detected as " $vmString
		./35/vm.sh
	elif [ "$vmString" != "QEMU" ]
	then
		echo "Not detected as a VM."
		./35/nonvm.sh
	else
		echo "error"
		exit
	fi
}
check_vm
