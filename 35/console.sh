#!/usr/bin/bash

repos(){
	./shared/repos.sh
}

hardware(){
	./shared/hardware.sh
}
amdgpu(){
	./shared/amdgpu.sh
}

desktop_extras(){
	./shared/de.sh
}

internet(){
	./shared/internet.sh
}

media_apps(){
	./shared/media_apps.sh
}

gaming_apps(){
	./34/gaming_apps.sh
}

controller_setup(){
	./shared/controller_setup.sh
}

utilities(){
	./shared/utilities.sh
}

cleanup(){
	./shared/cleanup.sh
}

repos
hardware
amdgpu
desktop_extras
internet
media_apps
gaming_apps
controller_setup
utilities
cleanup
