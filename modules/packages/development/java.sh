#!/usr/bin/bash

sudo dnf install -y adoptium-temurin-java-repository
sudo sed -i '/enabled=0/c enabled=1' /etc/yum.repos.d/adoptium-temurin-java-repository.repo
sudo dnf update -y
sudo dnf install -y temurin-21-jdk
sudo alternatives --set java /usr/lib/jvm/temurin-21-jdk/bin/java
