#!/bin/sh

MYSQL_ROOT_PASSWORD="00496CD69C0D2572FBBA705FC1D1"

echo "Initialisation de la base de données"
echo -n "- Création de la base de données 'alfresco'... "
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE DATABASE alfresco /*\!40100 DEFAULT CHARACTER SET utf8 */;" 2>/dev/null
echo "Ok"

echo -n "- Création de l'utilisateur 'alfresco' et application des privilèges... "
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE USER 'alfresco'@'%' IDENTIFIED BY 'PIaVomey6Qqa5EYbUWYGUzV98a';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "GRANT ALL PRIVILEGES ON alfresco.* TO 'alfresco'@'%';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "FLUSH PRIVILEGES;" 2>/dev/null
echo "Ok"

echo -n "- Importation des données... "
# cat ../data/alfresco/alfresco.sql | docker exec -i crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD alfresco 2>/dev/null
echo "Ok"
echo

echo "Initialisation des documents"
echo -n "- Copie des données (Cette opération va prendre plusieurs minutes)... "
# cat ../data/alfresco/alfresco.tar.bz2 | docker exec -i crilcq-website tar Cxjf /alf_data/ -
echo "Ok"
echo

