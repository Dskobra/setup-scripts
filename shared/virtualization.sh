#!/usr/bin/bash

virtualization(){
	sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
  -O /etc/yum.repos.d/virtio-win.repo
	sudo dnf install -y	virt-manager libvirt-client virtio-win
}

virtualization
