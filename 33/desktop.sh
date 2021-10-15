#!/usr/bin/bash

repos(){
	./shared/repos.sh
}
amdgpu(){
	./shared/amdgpu.sh
}

desktop_extras(){
	./shared/desktop_extras.sh
}

basic_apps(){
	./shared/basic_apps.sh
}

media_apps(){
	./shared/media_apps.sh
}

gaming_apps(){
	./33/gaming_apps.sh
}

coding_apps(){
	./shared/coding_apps.sh
}

razer(){
	./33/razer_app.sh
}

security_apps(){
	./33/security_apps.sh
}

controller_setup(){
	./shared/controller_setup.sh
}

repos
amdgpu
razer
desktop_extras
basic_apps
media_apps
gaming_apps
coding_apps
security_apps
controller_setup
