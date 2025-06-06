#!/usr/bin/bash

install_lact(){
    sudo dnf copr enable -y ilyaz/LACT
    sudo dnf install -y lact
    sudo systemctl enable --now lactd
}

install_lact
