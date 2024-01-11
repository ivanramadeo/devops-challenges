#!/bin/bash
sudo apt-get update

# Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Post instalación
sudo groupadd docker
sudo usermod -aG docker vagrant
newgrp docker

#Instalación de Jenkins
#Java
sudo apt-get install openjdk-11-jdk -y
# Agregamos la clave
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
#Agregamos el repositorio de Jenkins
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

# Actualizar e instalar Jenkins y Java
sudo apt-get update
sudo dpkg --configure -a

#Iniciar jenkins
sudo systemctl start jenkins

