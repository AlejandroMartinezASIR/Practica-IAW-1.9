#!/bin/bash

#Para mostrar los comandos que son ejecutables con -x, si se pone -ex nos muestra que comando falla
set -ex 

#Poner sudo cuando se vaya a lanzar el script
apt update

#Actualizar los paquetes del sistema
apt upgrade -y

#Instalamos el servidor web apache y poniendo -y no hace falta escribir nada
apt install apache2 -y

#Instalamos MySQL server
apt install mysql-server -y
