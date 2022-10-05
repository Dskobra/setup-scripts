#!/usr/bin/bash

install_mate_extras(){
	echo "Now setting up some extra mate features."
	sudo dnf install -y caja-dropbox caja-share \
	mate-menu
}
install_mate_extras