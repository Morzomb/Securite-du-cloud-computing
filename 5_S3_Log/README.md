# Guide d'Utilisation d'AWS S3 pour les Journaux d'Accès ELB

Ce document propose un guide détaillé pour configurer un environnement AWS utilisant S3 pour stocker les journaux d'accès d'un équilibreur de charge d'application (ELB). Suivez les tâches ci-dessous pour mettre en place cette configuration :

## Tâche 1 : Utiliser AWS S3 pour Stocker les Journaux d'Accès ELB
- Configurez un ELB pour envoyer les journaux d'accès à un compartiment S3.
- Les journaux d'accès fournissent des informations détaillées sur les requêtes traitées par l'ELB.

## Tâche 2 : Créer Deux Serveurs Web avec le Service Apache
- Lancez deux instances EC2 avec Apache installé et configuré.
- Les instances servent une page HTML avec des messages indiquant le serveur A ou B.

## Tâche 3 : Créer un Groupe Cible et un ELB
- Créez un groupe cible enregistrant les deux instances EC2.
- Mettez en place un ELB pour répartir le trafic entre les instances.
- Utilisez le protocole HTTP sur le port 80.

## Tâche 4 : Activer la Fonction de Journalisation d'Accès
- Activez la fonction de journalisation d'accès sur l'ELB.
- Spécifiez un compartiment S3 pour stocker les journaux.
- Créez le compartiment S3 si nécessaire.

## Tâche 5 : Tester l'ELB et les Journaux d'Accès
- Testez le fonctionnement de l'ELB en accédant à son nom DNS dans un navigateur.
- Accédez au compartiment S3 pour télécharger les fichiers de journaux d'accès générés.
- Examinez un exemple du format de fichier de journal d'accès.

Suivez ces tâches pour configurer un environnement AWS complet intégrant ELB, EC2, Apache et S3, offrant une solution robuste pour la gestion des journaux d'accès générés par l'équilibreur de charge d'application.
