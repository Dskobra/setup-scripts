#!/usr/bin/bash

repos(){
	./shared/repos.sh
}

amdgpu(){
	./shared/amdgpu.sh
}

server_desktop(){
	./shared/server_desktop.sh
}

server_apps(){
	./shared/server_apps.sh
}

repos
server_desktop
server_apps
security_apps
amdgpu
