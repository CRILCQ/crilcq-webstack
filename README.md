# crilcq-webstack
Solution docker-compose pour l'ensemble des ressources web du CRILCQ

## Déploiement initial

1. Obtenir les fichiers de base de la solution et la lancer :

    ```shell
    git clone https://github.com/CRILCQ/crilcq-webstack.git
    cd crilcq-webstack
    docker-compose up -d
    ```

2. Obtenir les fichiers contenant les données :

    ```shell
    cd data
    curl http://contemporain.info/migration/data.tar | tar -xv
    ```

3. Modifier le fichier d'environement (``.env`` dans la racine de la solution) en spécifiant les mots de passe souhaités pour les différents systèmes

4. Lancer les script d'initialisation :

    ```shell
    cd ../scripts
    ./init-website.sh
    ./init-alfresco.sh
    ```

5. Accéder au site publié à l'adresse http://www.crilcq.org. Il est nécessaire d'apporter des modifications à la configuration du service DNS local ou au fichier ``/etc/hosts`` du client si le déploiement est fait sur un autre système que celui référencé par les services DNS globaux.
