#! /usr/bin/bash

cp install/data/custom_paths /home/$USER
cd /home/$USER/
cat custom_paths >> .bashrc