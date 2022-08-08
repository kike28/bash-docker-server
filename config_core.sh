#!/bin/bash

echo '#########################################################'
echo '#########################################################'
echo 'Introduzca un nombre de usuario nuevo para manejar docker'
echo '#########################################################'
echo '#########################################################'

read usuarioDocker

echo '#########################################################'
echo '#########################################################'
echo 'El usuario es $usuarioDocker'
echo '#########################################################'
echo '#########################################################'

adduser $usuarioDocker
usermod -aG docker $usuarioDocker
#su $usuarioDocker
#cd ~/
git clone https://github.com/kike28/app-docker-server.git
mv app-docker-server/core/ /opt/
echo '#########################################################'
echo '#########################################################'
echo 'Ingresa un nuevo correo para Cambiar email del archivo traefik.yml'
echo '#########################################################'
echo '#########################################################'

read correoTraefik
sed -i 's/email: tucorreo@mail.com/email: '$correoTraefik'/' /opt/core/traefik-data/traefik.yml

#Instalar apache-utils
apt install -y apache2-utils

# ESTE ES PARA GENERAR CONTRASE:A DE TRAEFIK
echo '#########################################################'
echo '#########################################################'
echo 'Ahora vamos a generar la contrasena encriptada de tu traefik'
echo 'Introduzca nombre de usuario de Traefik'
echo '#########################################################'
echo '#########################################################'


read usuarioTraefik

echo '#########################################################'
echo '#########################################################'
echo 'Introduzca Contrasena de usuario de Traefik'
echo '#########################################################'
echo '#########################################################'

read -s contrasenaTraefik
contrasenaTraefikfinal=$(htpasswd -nb $usuarioTraefik $contrasenaTraefik)
#echo $contrasenaTraefikfinal

#CAMBIAR PERMISO DE
 chmod 600 /opt/core/traefik-data/acme.json

#AGREGAR contrasena en el archivo dynamic.yml
contrasenaDefaulttraefik='enrique:$apr1$ZeOc\/mrN$KTGGyWGpp3\/1vPzhBu3as1'
sed -i 's#'$contrasenaDefaulttraefik'#'$contrasenaTraefikfinal'#' /opt/core/traefik-data/configurations/dynamic.yml


chown $usuarioDocker:$usuarioDocker -R /opt/core/

echo '#########################################################'
echo '#########################################################'
echo 'Tareas finalizadas con exito'
echo '#########################################################'
echo '#########################################################'


#https://es.ccm.net/ordenadores/linux/4172-sed-introduccion-a-sed-parte-ii/