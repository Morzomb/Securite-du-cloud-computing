# Guide de Chiffrement d'un Seau S3 avec AWS KMS et Surveillance avec CloudTrail

Ce document a pour objectif d'expliquer comment chiffrer un seau S3 en utilisant AWS Key Management Service (KMS) et comment surveiller les activités liées au chiffrement avec CloudTrail.

## Objectif du Document
Le guide vise à montrer comment sécuriser un seau S3 en chiffrant les objets avec AWS KMS tout en surveillant les activités associées à l'utilisation de la clé KMS avec CloudTrail.

## Étapes du Document
Le processus est divisé en huit tâches :

### Tâche 1 : Se Connecter à la Console AWS Management
- Utilisez vos identifiants AWS pour accéder à la console AWS Management.

### Tâche 2 : Créer une Clé KMS Gérée par le Client
- Créez une clé KMS gérée par le client pour le chiffrement des objets.

### Tâche 3 : Créer un Seau S3
- Créez un seau S3 dédié au téléchargement, au chiffrement des objets, et au stockage des événements.

### Tâche 4 : Configurer CloudTrail
- Créez et configurez un service CloudTrail pour stocker les événements KMS dans le seau S3 dédié.

### Tâche 5 : Télécharger et Chiffrer un Objet
- Téléchargez un objet dans le seau S3 et chiffrez-le en utilisant la clé KMS précédemment créée.

### Tâche 6 : Essayer d'Accéder à l'Objet Chiffré
- Tentez d'accéder à l'objet chiffré via la console S3 et l'URL de l'objet.

### Tâche 7 : Accéder et Visualiser les Fichiers Journaux CloudTrail
- Consultez les fichiers journaux CloudTrail dans le seau S3 relatifs aux opérations de chiffrement KMS.

## Conclusion du Document
En suivant ces étapes, le document démontre comment utiliser AWS KMS et CloudTrail pour sécuriser et surveiller les objets stockés dans un seau S3, renforçant ainsi la sécurité et la traçabilité des opérations de chiffrement.
