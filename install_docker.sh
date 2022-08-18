#!/bin/bash
# Actualizar Sistema
apt update && sudo apt upgrade -y

# Remover docker Uninstall old versions
apt remove docker-ce docker-ce-cli containerd.io -y
apt remove docker docker-engine docker.io containerd runc -y

# 
# Actualizar el índice de paquetes apt e instalar paquetes para permitir que apt utilice un repositorio a través de HTTPS:
# 
apt update
apt install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

# Añade la clave GPG oficial de Docker
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Utilice el siguiente comando para configurar el repositorio:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

echo "#########################################"
echo "##############LISTO######################"
echo "#########################################"

shutdown -r 0