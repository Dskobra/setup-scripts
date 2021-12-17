#!/usr/bin/bash

repos(){
	./shared/repos.sh
}

hardware(){
	./shared/hardware.sh
}

desktop_extras(){
	./shared/desktop_extras.sh
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
	./34/gaming_apps.sh
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
desktop_extras
basic_apps
office
internet
media_apps
gaming_apps
editors
coding_tools
controller_setup
utilities
virtualization
cleanup