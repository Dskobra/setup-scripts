#!/usr/bin/bash

repos(){
	./shared/repos.sh
}

desktop_extras(){
	./shared/de.sh
}

basic_apps(){
	./shared/basic_apps.sh
}


internet(){
	./shared/internet.sh
}

media_apps(){
	./shared/media_apps.sh
}

utilities(){
	./shared/utilities.sh
}

cleanup(){
	./shared/cleanup.sh
}

repos
desktop_extras
basic_apps
internet
media_apps
gaming_apps
utilities
cleanup