#!/usr/bin/bash

help(){
    echo "//native//"
    echo "These are applications that are built for Fedora in an RPM format. Normally they perform better and consume less disk"
    echo "space. Generally recommended for most applications (except audio/video codecs as they involve more install steps and"
    echo "may break on updates)."
    echo ""
    echo ""
    echo "//flatpak//"
    echo "These are applications that are built for all distros using a neutral format. Some developers consider flatpaks their"
    echo "officially supported release. Automatically handles installing required components and audio/video codecs at the cost"
    echo "of more disk space. Generally recommended for applications involving audio/video codecs or when officially supported."
    echo ""
    echo ""
    echo "//script//"
    echo "Rclone and nodejs are 2 applications installed through official/community maintained scripts."
    echo "-Rclone script downloads rclone into /usr/bin/rclone and requries running the script available at "
    echo "(https://rclone.org/downloads/) in order to update."
    echo ""
    echo "-Nodejs is installed through the community made nvm (node version manager) script. This allows helps easily manage"
    echo "multiple nodejs installs. Simply run 'nvm' to manage it."
}

help
