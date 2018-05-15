#!/bin/bash
source ../.env

echo "Initialisation d'Alfresco"
echo -n "- Création de la base de données 'alfresco'... "
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE DATABASE alfresco;" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "ALTER DATABASE alfresco CHARACTER SET utf8 COLLATE utf8_unicode_ci;" 2>/dev/null
echo "Ok"

echo -n "- Création de l'utilisateur 'alfresco' et application des privilèges... "
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE USER 'alfresco'@'%' IDENTIFIED BY '$MYSQL_ALFRESCO_PASSWORD';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "GRANT ALL PRIVILEGES ON alfresco.* TO 'alfresco'@'%';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "FLUSH PRIVILEGES;" 2>/dev/null
echo "Ok"

echo -n "- Copie des fichiers de configuration... "
docker exec crilcq-alfresco rm -rf /var/lib/tomcat7/shared
docker exec crilcq-alfresco mkdir -p /var/lib/tomcat7/shared
cat ../data/alfresco/alfresco-shared.tar.bz2 | docker exec -i crilcq-alfresco tar Cxjf /var/lib/tomcat7/shared/ -
echo "Ok"

echo -n "- Importation des données de la base de données... "
cat ../data/alfresco/alfresco.sql | docker exec -i crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD alfresco 2>/dev/null
echo "Ok"

echo -n "- Copie des documents (l'opération va prendre plusieurs minutes)... "
cat ../data/alfresco/alf_data.tar.bz2 | docker exec -i crilcq-alfresco tar Cxjf /alf_data/ -
echo "Ok"

echo -n "- Application du nouveau mot de passe... "
docker exec crilcq-alfresco /bin/sed -Ei "s/db\.password=.*$/db.password=$MYSQL_ALFRESCO_PASSWORD/g" /var/lib/tomcat7/shared/classes/alfresco-global.properties
echo "Ok"

echo -n "- Nettoyage/activation... "
docker exec crilcq-alfresco rm /usr/share/tomcat7/CONFIGURATION_NEEDED
echo "Ok"
