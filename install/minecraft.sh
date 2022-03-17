#!/usr/bin/bash

minecraft(){
	flatpak -y install flathub com.mojang.Minecraft
	#cd /home/$USER/Games
	#wget https://launcher.mojang.com/download/Minecraft.tar.gz
	#tar -xvf Minecraft.tar.gz
	#rm Minecraft.tar.gz
}

minecraft
