# crilcq-webstack

Solution docker-compose pour l'ensemble des ressources web du CRILCQ

## Déploiement initial

1. Obtenir les fichiers de base de la solution et la lancer :

    ```shell
    git clone https://github.com/CRILCQ/crilcq-webstack.git
    cd crilcq-webstack
    ```

2. Modifier le fichier d'environement en spécifiant les mots de passe souhaités pour les différents systèmes

    ```shell
    nano .env
    ```

3. Lancer la stack :

    ```shell
    docker-compose up -d
    ```

4. Obtenir les fichiers contenant les données :

    ```shell
    cd data
    curl http://{hostname/chemin}/data.tar | tar -xv
    ```

5. Lancer les script d'initialisation :

    ```shell
    cd ../scripts
    ./init-stack.sh
    ```

6. Tester l'accès aux sites publiés:
    - <http://www.crilcq.org>
    - <http://alfresco.crilcq.org/alfresco>

    Il est nécessaire d'apporter des modifications à la configuration du service DNS local ou au fichier ``/etc/hosts`` du client si le déploiement est fait sur un autre système que celui référencé par les services DNS globaux.
