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

basic_apps(){
	./shared/basic_apps.sh
}

office(){
	./shared/office.sh
}

internet(){
	./shared/internet.sh
}

media_apps(){
	./shared/media_apps.sh
}

gaming_apps(){
	./35/gaming_apps.sh
}

wowapps(){
	./shared/wowapps.sh
}

coding_tools(){
	./shared/coding_tools.sh
}

editors(){
	./shared/editors.sh
}

controller_setup(){
	./shared/controller_setup.sh
}

utilities(){
	./shared/utilities.sh
}

virtualization(){
	./shared/virtualization.sh
}

cleanup(){
	./shared/cleanup.sh
}

repos
hardware
amdgpu
desktop_extras
basic_apps
office
internet
media_apps
gaming_apps
wowapps
editors
coding_tools
controller_setup
utilities
virtualization
cleanup