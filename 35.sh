#!/usr/bin/bash

echo "Dsk Fedora setup script"

check_vm(){
	vmString=$(sudo dmidecode -s system-manufacturer)
	if [ "$vmString" = "QEMU" ]
	then
		echo "VM Detected as: $vmString"
		./35/vm.sh
	elif [ "$vmString" != "QEMU" ] || [ "$vmString" != "innotek GmbH" ]
	then
		echo "Device detected as $vmString. Setting up device as normal."
		./35/nonvm.sh
	else
		echo "error"
		exit
	fi
}
check_vm
