#!/bin/bash
#Actualizamos el servidor

apt-get update

#Instalamos nginx

apt-get install nginx -y

#Instalamos phppp-fpm para iteraccionar con el sistema gestor de base de datos

apt-get install php-fpm php-mysql

#Configuramos php-fpm cambiando una linea de codifo por otra solo modificamos el ; que es liminado y el 1 por el 0

sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.2/fpm/php.ini

#Reiniciamos el servicio

systemctl restart php7.2-fpm -y

#Configuramos nginx para php

rm /etc/nginx/sites-available/default

#Descargamos el archivo de configuracion modificado de mi repositorio

git clone https://github.com/manueljesus1995/archivos-conf.git

#Entramos en el repositorio

cd /archivos-conf

#movemos el archivo situado en la primara ruta a la ruta de destino que es la segunda

mv /home/ubuntu/archivos-conf/default /etc/nginx/sites-available/

cd /var/www/html

#Nos bajamos el repositorio de la bse de datos

git clone https://github.com/josejuansanchez/iaw-practica-lamp

#Cambiamos el propietario del repositorio

chown www-data:www-data * -R

#Accedemos al directorio y configuramos la base de datos para que busque en la maquina en la que tenemos mysql en lugar de buscar en localhost

sed -i 's/localhost/54.147.58.211/' /iaw-practica-lamp/src/config.php

#Reiniciamos nginx

systemctl restart nginx

