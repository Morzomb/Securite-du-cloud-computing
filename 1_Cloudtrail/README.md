# Guide d'utilisation d'AWS CloudTrail et EC2

Ce guide fournit des instructions étape par étape pour configurer AWS CloudTrail, lancer une instance EC2, et effectuer des vérifications associées. Les principales tâches incluent :

## Tâche 1 : Configuration de CloudTrail et d'un bucket S3
- Utiliser AWS CloudTrail pour enregistrer les appels d'API et les événements AWS.
- Choisir la région eu-west-1 ou eu-west-3.
- Créer un trail avec un nom et un tag spécifiques.
- Laisser les autres paramètres par défaut.

## Tâche 2 : Vérification du bucket S3
- Accéder au service S3 pour visualiser le bucket créé par CloudTrail.

## Tâche 3 : Consultation des journaux dans le bucket S3
- Attendre quelques minutes pour la création du premier journal.
- Ouvrir le journal et le formater avec JSONFormatter.

## Tâche 4 : Lancement d'une instance EC2
- Sélectionner l'image Amazon Linux 2 AMI et le type d'instance t2.micro.
- Ajouter des commandes dans les données utilisateur.
- Choisir un profil IAM esgi_EC2_Role.
- Lancer l'instance sans clé.

## Tâche 5 : Vérification des fichiers journaux de l'instance EC2
- Revenir au bucket S3 et attendre la création du journal.
- Ouvrir le journal et le formater avec JSONFormatter pour voir les événements liés au lancement de l'instance EC2.

## Tâche 6 : Connexion à l'instance EC2
- Sélectionner l'instance EC2.
- Utiliser la méthode EC2 Instance Connect (SSM connection) pour se connecter à l'instance.
- Vérifier la connexion à l'instance.

## Tâche 7 : Vérification du fichier journal après la connexion à l'instance EC2
- Revenir au bucket S3.
- Ouvrir le journal créé après la connexion.
- Formater avec JSONFormatter pour voir les détails de l'événement lié à la connexion à l'instance EC2.

## Tâche 8 : Destruction de toutes les ressources créées
- Supprimer toutes les ressources créées au cours des tâches précédentes.

Suivez ces étapes pour mettre en place, vérifier et interagir avec AWS CloudTrail et EC2, avec une attention particulière à la gestion des journaux d'activité pour la sécurité et la surveillance.
