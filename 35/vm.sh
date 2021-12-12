#!/usr/bin/bash

repos(){
	./shared/repos.sh
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

internet(){
	./shared/internet.sh
}

media_apps(){
	./shared/media_apps.sh
}

coding_tools(){
	./shared/coding_tools.sh
}

editors(){
	./shared/editors.sh
}

virtualization(){
	./shared/virtualization.sh
}

cleanup(){
	./shared/cleanup.sh
}

repos
desktop_extras
basic_apps
internet
media_apps
editors
coding_tools
utilities
cleanup