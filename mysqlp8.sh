#!/bin/bash
#Actualizacion de Repositorios
apt-get update

#Instalamos las debconf-utils
apt-get install debconf-utils -y

#Instalamos las librerias de apache para MYSQL
apt-get install php libapache2-mod-php php-mysql -y

#Configuramos la contraseña del root

DB_ROOT_PASSWD=root

debconf-set-selections <<<"mysql-server mysql-server/root_password password $DB_ROOT_PASSWD"
debconf-set-selections <<<"mysql-server mysql-server/root_password_again password $DB_ROOT_PASSWD"

#Instalamos MYSQL SERVER

apt-get install mysql-server -y

#Configuramos que se pueda acceder desde cualquier equipo

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

#Instalamos git 

apt-get install git -y

#Configuramos la aplicacion web

DB_NAME=wp_db
DB_USER=wp_user
DB_PASSWD=wp_user

mysql -u root -p$DB_ROOT_PASSWD <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWD <<< "CREATE DATABASE $DB_NAME;"
mysql -u root -p$DB_ROOT_PASSWD <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'%' IDENTIFIED BY '$DB_PASSWD';"
mysql -u root -p$DB_ROOT_PASSWD <<< "FLUSH PRIVILEGES;"

#Reiniciamos el servicio mysql
systemctl restart mysql

