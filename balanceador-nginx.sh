#!/bin/bash

set -x

apt-get update


# Instalamos nginx

apt-get install nginx -y

#Borramos el archivo de configuracion

rm /etc/nginx/sites-available/default

#DEscargamos archvico modificado

git clone https://github.com/manueljesus1995/archivo-conf-balan-nginx.git

#Entramos en la carpta y movemos a la ruta de destino

mv /home/ubuntu/archivo-conf-balan-nginx/default /etc/nginx/sites-available

#Reiniciamo nginx

systemctl restart nginx

