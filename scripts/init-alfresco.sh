#!/bin/bash
source ../.env

echo "Initialisation d'Alfresco"
echo -n "- Création de la base de données 'alfresco'... "
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE DATABASE alfresco /*\!40100 DEFAULT CHARACTER SET utf8 */;" 2>/dev/null
echo "Ok"

echo -n "- Création de l'utilisateur 'alfresco' et application des privilèges... "
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE USER 'alfresco'@'%' IDENTIFIED BY '$MYSQL_ALFRESCO_PASSWORD';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "GRANT ALL PRIVILEGES ON alfresco.* TO 'alfresco'@'%';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "FLUSH PRIVILEGES;" 2>/dev/null
echo "Ok"

echo -n "- Importation des données de la base de données... "
# cat ../data/alfresco/alfresco.sql | docker exec -i crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD alfresco 2>/dev/null
echo "Ok"

echo -n "- Copie des fichiers (l'opération va prendre plusieurs minutes)... "
# cat ../data/alfresco/alfresco.tar.bz2 | docker exec -i crilcq-website tar Cxjf /alf_data/ -
echo "Ok"

echo -n "- Application du nouveau mot de passe... "
docker exec crilcq-alfresco /bin/sed -Ei "s/db\.password=.*$/db.password=$MYSQL_ALFRESCO_PASSWORD/g" /var/lib/tomcat7/shared/classes/alfresco-global.properties
echo "Ok"

echo -n "- Nettoyage/activation... "
docker exec crilcq-alfresco rm /usr/share/tomcat7/CONFIGURATION_NEEDED
echo "Ok"


