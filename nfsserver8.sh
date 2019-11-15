#!/bin/bash
set -x

#Instalación de paquetes necesarios en el servidor NFS:
#apt-get update
apt-get install nfs-kernel-server -y

#Entramos en html
cd /var/www/html

# Descargar la ultima version de wordpress
wget https://es.wordpress.org/latest-es_ES.tar.gz

# Descomprimimos el rar
tar -xzvf latest-es_ES.tar.gz 

# borramos wordpress y sacamos todo 
mv /var/www/html/wordpress/* /var/www/html

rm /var/www/html/wordpress

#Cambiamos el propietario del repositorio
chown www-data:www-data * -R

#Cambiamos el nombre del archivo que se ve en primer lugar por el segundo.
mv wp-config-sample.php wp-config.php

#Introducimos las siguientes entradas en el archivo de configuracion wp-config.php para sustituirlas por las existentes.
sed -i 's/'database_name_here'/'wp_db'/' wp-config.php
sed -i 's/'username_here'/'wp_user'/' wp-config.php
sed -i 's/'password_here'/'wp_user'/' wp-config.php
sed -i 's/'localhost'/'52.91.57.43'/' wp-config.php

#Damos permisos de lectura al fichero de configuracion.
chmod +x wp-config.php 

#Introducir las siguientes lineas. la ip del balanceador
echo "define( 'WP_SITEURL', 'http://3.86.112.221' );" >> wp-config.php
echo "define( 'WP_HOME', 'http://3.86.112.221' );" >> wp-config.php

#movemos el index.php a la carpeta html lo cambiamos a un directorio que no es la raiz
#cp /var/www/html/worpress/index.php ../

# a continuacion reempleazamos el contenido del index.php que esta fuera
#sed -i 's#wp-blog-header.php#/wordpress/wp-blog-header.php#' /var/www/html/index.php

#Añadimos la siguiente línea al archivo exports la ip del cliente
echo "/var/www/html/wordpress      3.94.10.1(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports

# Security Keys

#Borramos las keys 
sed -i '/AUTH_KEY/d' /var/www/html/wp-config.php
sed -i '/LOGGED_IN_KEY/d' /var/www/html/wp-config.php
sed -i '/NONCE_KEY/d' /var/www/html/wp-config.php
sed -i '/AUTH_SALT/d' /var/www/html/wp-config.php
sed -i '/SECURE_AUTH_SALT/d' /var/www/html/wp-config.php
sed -i '/LOGGED_IN_SALT/d' /var/www/html/wp-config.php
sed -i '/NONCE_SALT/d' /var/www/html/wp-config.php

#Añadimos las keys
CLAVES=$(curl https://api.wordpress.org/secret-key/1.1/salt/)
CLAVES=$(echo $CLAVES | tr / _)
sed -i "/#@-/a $CLAVES" /var/html/wp-config.php

#Cambiamos los permisos al directorio que vamos a compartir:
chown nobody:nogroup /var/www/html/

#Reiniciamos el servicio nfs
/etc/init.d/nfs-kernel-server restart
