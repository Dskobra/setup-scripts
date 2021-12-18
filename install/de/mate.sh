#!/usr/bin/bash

mate(){
	echo "Now setting up some extra mate features."
	sudo dnf install -y caja-dropbox caja-share \
	mate-menu
}
mate