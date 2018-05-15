#!/bin/bash
source ../.env

echo "Initialisation d'Orion"

echo -n "- Copie des fichiers... "
cat ../data/orion/orion.tar.bz2 | docker exec -i crilcq-orion tar Cxjf /usr/local/apache2/htdocs -
echo "Ok"
