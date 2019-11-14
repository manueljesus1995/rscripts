#!/bin/bash
set -x

#Instalación de paquetes necesarios en el cliente NFS:
apt-get update
apt-get install nfs-common -y

#Creamos el punto de montaje en el cliente 
mount 52.91.77.158:/var/www/html/wordpress /var/www/html/wordpress

#Añadimos la siguiente linea en el archivo /etc/fstab
echo "52.91.77.158:/var/www/html/wordpress /var/www/html/wordpress  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab

# Configuramos WP en un directorio que no es la raíz
cd /var/www/html/wordpress
mv /var/www/html/wordpress/index.php ../
sed -i 's#wp-blog-header.php#/wordpress/wp-blog-header.php#' /var/www/html/index.php

#Reiniciamos el servicio nfs
/etc/init.d/nfs-common restart
