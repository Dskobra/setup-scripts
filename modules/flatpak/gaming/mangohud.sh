#!/usr/bin/bash

install_mangohud(){
    mkdir $HOME/.config/MangoHud
    flatpak install --user -y runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08
}

install_mangohud