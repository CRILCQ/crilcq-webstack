#!/bin/sh

MYSQL_ROOT_PASSWORD="00496CD69C0D2572FBBA705FC1D1"
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE DATABASE typo3 /*\!40100 DEFAULT CHARACTER SET utf8 */;" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "CREATE USER 'typo3'@'%' IDENTIFIED BY 'GNpI4uz22dc3VX6VC';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "GRANT ALL PRIVILEGES ON typo3.* TO 'typo3'@'%';" 2>/dev/null
docker exec crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD -ss -e "FLUSH PRIVILEGES;" 2>/dev/null
cat ../data/website/typo3.sql | docker exec -i crilcq-mysql /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD typo3 2>/dev/null

cat ../data/website/typo3.tar.bz2 | docker exec -i crilcq-website tar Cxjf /var/www/html/ -
