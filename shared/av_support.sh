#!/usr/bin/bash

av_support(){
	sudo dnf install -y gstreamer1-plugin-openh264 \
	mozilla-openh264 ffmpeg
	flatpak install -y flathub org.videolan.VLC
}

av_support