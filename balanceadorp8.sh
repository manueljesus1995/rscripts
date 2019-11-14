#!/bin/bash

#Instalamos apache

apt-get update

apt-get install apache2 -y

#Activamos los siguientes modulos

a2enmod proxy
a2enmod proxy_http
a2enmod proxy_ajp
a2enmod rewrite
a2enmod deflate
a2enmod headers
a2enmod proxy_balancer
a2enmod proxy_connect
a2enmod proxy_html
a2enmod lbmethod_byrequests

#Reinciamos el apache2

/etc/init.d/apache2 restart

#Nos situamos en la caperta personl del usuario para bajar el repositorio

cd /home/ubuntu

#Descargamos mi repositorio de github para bajar el archivo 000-default.conf modificado

rm -rf archivo-conf-balanceador.git

git clone https://github.com/manueljesus1995/archivo-conf-balanceador.git

#Accedemos a la ruta del archivo y lo eliminamos o en mi caso opto por poner ruta absoluta y lo eliminamos

rm /etc/apache2/sites-available/000-default.conf

#Movemos el archivo descargado e la ruto donde se encontraba el original

mv /home/ubuntu/archivo-conf-balanceador/000-default.conf /etc/apache2/sites-available/

#Reiniciamos apache2 para que se efectuen los cambios

/etc/init.d/apache2 restart
