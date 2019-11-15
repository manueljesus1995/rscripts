#!/bin/bash
set -x

#Para ejecutar el escript lo aremos como superusuario para evitar que nos pida contraseñas
#Actualizacion de Repositorios
apt-get update

#Instalamos apache 2
apt-get install apache2 -y

#Instalamos las librerias de apache para MYSQL
apt-get install php libapache2-mod-php php-mysql -y 

#Cambiamos el propietario del repositorio
cd /var/www/html

chown www-data:www-data * -R

# nos descargamso el .htacces ya modificado.
cd /home/ubuntu

#rm -rf archivo-conf-balanceador

#Descargamos del repositorio el archivo htaccess
#git clone https://github.com/manueljesus1995/archivo-conf-balanceador.git

#Movemos el archivo htaccess
#mv /archivo-conf-balanceador/htaccess /var/www/html/.htaccess

#ejecucion del cliente servidor

cd $HOME/scripst.sh
if [ $1 = "server" ];
    then ./nfsserver8.sh
elif [ $1= "client" ];
    then ./nfclientep8.sh
fi

#Reiniciamos Apache.
systemctl restart apache2

