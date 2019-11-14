#!/bin/bash
#Actualizacion de Repositorios

 apt-get update

#Instalamos apache 2

apt-get install apache2 -y

#Instalamos las librerias de apache para MYSQL

apt-get install php libapache2-mod-php php-mysql -y 

#instalamos adminer

sudo mkdir /var/www/html/adminer

cd /var/www/html/adminer 

wget https://github.com/vrana/adminer/releases/download/v4.7.3/adminer-4.7.3-mysql.php

mv adminer-4.7.3-mysql.php index.php

#Instalamos git para poder trabajar
apt-get install git -y

#Instalamos las debconf-utils

apt-get install debconf-utils -y

cd /var/www/html

#Nos bajamos el repositorio

git clone https://github.com/josejuansanchez/iaw-practica-lamp

#Cambiamos el propietario del repositorio

chown www-data:www-data * -R

#Accedemos al directorio y configuramos la base de datos para que busque en la maquina en la que tenemos mysql en lugar de buscar en localhost

sed -i 's/localhost/3.87.227.73/' /var/www/html/iaw-practica-lamp/src/config.php
