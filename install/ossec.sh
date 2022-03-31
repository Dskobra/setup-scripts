	#!/usr/bin/bash

ossec(){
    OSSECLINK=https://updates.atomicorp.com/channels/atomic/fedora/35/x86_64/RPMS/atomic-release-1.0-23.fc35.art.noarch.rpm
	OSSECBINARY=atomic-release-1.0-23.fc35.art.noarch.rpm
	wget $OSSECLINK
    sudo rpm -i $OSSECBINARY
    sudo dnf update -y
}
ossec