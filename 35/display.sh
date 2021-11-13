#!/usr/bin/bash

repos(){
	./shared/repos.sh
}

desktop_extras(){
	./shared/desktop_extras.sh
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
internet
media_apps
utilities
cleanup