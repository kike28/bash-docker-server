#!/bin/bash

echo '#########################################################'
echo '#########################################################'
echo 'Introduzca un nombre de usuario nuevo, que será el usuario'
echo 'con los permisos para manejar docker en el sistema'
echo '#########################################################'
echo '#########################################################'

read usuarioDocker

echo '#########################################################'
echo '#########################################################'
#echo 'El usuario es ' $usuarioDocker
echo '#########################################################'
echo '#########################################################'

adduser $usuarioDocker
usermod -aG docker $usuarioDocker
git clone https://github.com/kike28/app-docker-server.git
mv app-docker-server/core/ /opt/
echo '###########################################################################'
echo '###########################################################################'
echo 'Ingresa el Correo para administracion de Certficado SSL '
echo 'el archivo a configurar se encuentra en /opt/core/traefik-data/traefik.yml'
echo '###########################################################################'
echo '###########################################################################'

read correoTraefik
sed -i 's/email: tucorreo@mail.com/email: '$correoTraefik'/' /opt/core/traefik-data/traefik.yml

#Instalar apache-utils
apt install -y apache2-utils

# ESTE ES PARA GENERAR CONTRASE:A DE TRAEFIK
echo '#########################################################'
echo '#########################################################'
echo 'Ahora vamos a generar la contrasena encriptada de traefik'
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
echo 'La contraseña de traefik la puede encontrar en '
echo '/opt/core/traefik-data/configurations/dynamic.yml'
echo '#########################################################'
echo '#########################################################'
echo 'Tareas de configuración realizadas con exito'
echo 'Ahora solo resta configurar el archivo docker-compose.yml'
echo 'que se encuentra en la ruta /opt/core'
echo 'cambia los nombre de dominio a los que necesites'
echo 'luego corre en comando docker compose up -d'
echo '#########################################################'
echo '#########################################################'


#https://es.ccm.net/ordenadores/linux/4172-sed-introduccion-a-sed-parte-ii/