#!/usr/bin/bash

help(){
    echo "//native//               These are applications that are built for Fedora in an RPM format. Normally they perform better and consume less space."
    echo "                         Generally recommended for most applications (except audio/video codecs as they involve more install steps and may"
    echo "                         break on updates)"
    echo ""
    echo ""
    echo "//flatpak//              These are applications that are built for all distros using a neutral format. Some developers consider flatpaks their"
    echo "                         officially supported release. Automatically handles installing required components and audio/video codecs at the cost"
    echo "                         of more space. Generally recommended for applications involving audio/video codecs or when officially supported."
}

help
