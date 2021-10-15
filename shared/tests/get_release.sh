#!/usr/bin/bash

get_release(){
	source /etc/os-release
	getRelease=$(echo $VERSION_ID)
	echo $getRelease
}
