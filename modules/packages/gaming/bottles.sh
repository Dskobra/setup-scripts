#!/usr/bin/bash

flatpak_bottles(){
    mkdir $HOME/bottles
    flatpak install --user -y flathub com.usebottles.bottles
    flatpak override com.usebottles.bottles --user --filesystem=xdg-config/MangoHud:ro
    fi
}


flatpak_bottles
