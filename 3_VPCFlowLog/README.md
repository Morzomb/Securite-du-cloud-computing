# Configuration de VPC Flow Logs avec AWS

Ce guide détaille les étapes pour configurer VPC Flow Logs, un service permettant de capturer et d'enregistrer des informations sur le trafic réseau dans un VPC. Les principales tâches sont les suivantes :

## Tâche 1 : Création d'un groupe de journaux CloudWatch
- Mise en place d'un groupe de journaux CloudWatch pour stocker les données de VPC Flow Logs.

## Tâche 2 : Création d'un VPC
- Création d'un VPC avec un bloc CIDR IPv4 personnalisé et un nom distinctif.

## Tâche 3 : Configuration d'une passerelle Internet
- Création d'une passerelle Internet et son attachement au VPC.
- Modification de la table de routage principale pour ajouter une route vers la passerelle Internet.

## Tâche 4 : Création d'un sous-réseau
- Création d'un sous-réseau dans le VPC avec une zone de disponibilité et un bloc CIDR IPv4 spécifiques.

## Tâche 5 : Configuration de VPC Flow Logs
- Création d'un VPC Flow Log avec un nom, un filtre, un intervalle d'agrégation, une destination, et un rôle IAM définis.
- Vérification de l'état du VPC Flow Log dans l'onglet Flow Logs du VPC.

## Tâche 6 : Création d'une instance EC2
- Création d'une instance EC2 dans le sous-réseau du VPC avec une image, un type, un groupe de sécurité, et un rôle IAM choisis.
- Ajout de données utilisateur pour installer et démarrer un agent SSM.
- Notation de l'heure de création et de l'adresse IP publique de l'instance.

## Tâche 7 : Connexion à l'instance EC2 et installation d'un serveur Apache
- Connexion à l'instance EC2 via le gestionnaire de session.
- Installation d'un serveur Apache et test du serveur en accédant à l'adresse IP publique de l'instance dans un navigateur.

## Tâche 8 : Consultation des journaux CloudWatch
- Accès au groupe de journaux CloudWatch créé précédemment.
- Observation du flux de journaux correspondant au VPC Flow Log, en particulier des événements de journal reflétant le trafic vers l'instance EC2.

## Tâche 9 : Suppression de toutes les ressources
- Suppression de toutes les ressources créées au cours des étapes précédentes.

Suivez ces étapes pour mettre en place et tester VPC Flow Logs, observer le trafic réseau, et consulter les journaux CloudWatch pour une gestion proactive de votre infrastructure AWS.
