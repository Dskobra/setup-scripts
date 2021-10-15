#!/usr/bin/bash

repos(){
	./shared/repos.sh
}

get_desktop_extras(){
	./shared/get_desktop_extras.sh
}

basic_apps(){
	./shared/vm_basic_apps.sh
}

media_apps(){
	./shared/media_apps.sh
}

gaming_apps(){
	./gaming_apps_33.sh
}

coding_apps(){
	./shared/vm_coding_apps.sh
}

repos
get_desktop_extras
basic_apps
media_apps
gaming_apps
coding_apps
