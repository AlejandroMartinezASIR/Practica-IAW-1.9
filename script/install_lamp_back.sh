#!/bin/bash

#Para mostrar los comandos que son ejecutables con -x, si se pone -ex nos muestra que comando falla
set -ex 

source .env

#Poner sudo cuando se vaya a lanzar el script
apt update

#Actualizar los paquetes del sistema
apt upgrade -y

#Instalamos MySQL server
apt install mysql-server -y

#configuramos el config de mysql
sed -i s/127.0.0.1/$BACKEND_MYSQL_PRIVATE_IP/ /etc/mysql/mysql.conf.d/mysqld.cnf

mysql -u root <<< "DROP USER IF EXISTS $WORDPRESS_DB_USER@$FRONTEND_PRIVATE_IP;"
 mysql -u root <<< "CREATE USER $WORDPRESS_DB_USER@$FRONTEND_PRIVATE_IP IDENTIFIED BY $WORDPRESS_DB_PASSWORD;"
 mysql -u root <<< "GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO $WORDPRESS_DB_USER@$FRONTEND_PRIVATE_IP;"
 mysql -u root <<< "FLUSH PRIVILEGES;"

#reiniciamos el servicio
systemctl restart mysql

