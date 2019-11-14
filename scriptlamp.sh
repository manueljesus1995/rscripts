#!/bin/bash
#Actualizacion de Repositorios

apt-get update

#Instalamos apache 2

apt-get install apache2 -y

#Instalamos la libreria de apache 

apt-get install php libapache2-mod-php php-mysql -y 

#Instalamos adminer

sudo mkdir /var/www/html/adminer

cd /var/www/html/adminer 

wget https://github.com/vrana/adminer/releases/download/v4.7.3/adminer-4.7.3-mysql.php

mv adminer-4.7.3-mysql.php index.php

#Instalamos las debconf-utils

apt-get install debconf-utils -y

# Instalamos mySQL Server

DB_ROOT_PASSWD=root

debconf-set-selections <<<"mysql-server mysql-server/root_password password $DB_ROOT_PASSWD"
debconf-set-selections <<<"mysql-server mysql-server/root_password_again password $DB_ROOT_PASSWD"

# Instalamos git
apt-get install git -y

#Instalamos MySQL Server
apt-get install mysql-server -y

cd /var/www/html

git clone https://github.com/josejuansanchez/iaw-practica-lamp


#Cambiamos el propietario del repositorio

chown www-data:www-data * -R

#Configuramos la aplicacion web

DB_NAME=lamp_db
DB_USER=lamp_user
DB_PASSWD=lamp_user

mysql -u root -p$DB_ROOT_PASSWD <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWD <<< "CREATE DATABASE $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWD <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASSWD';"
mysql -u root -p$DB_ROOT_PASSWD <<< "FLUSH PRIVILEGES;"

#Importamos la base de datos de iaw-practica-lamp

mysql -u root -p$DB_ROOT_PASSWD <  /var/www/html/iaw-practica-lamp/db/database.sql
