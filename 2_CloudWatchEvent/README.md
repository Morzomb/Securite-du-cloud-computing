# Configuration des notifications d'événements avec AWS CloudWatch Events

Ce guide détaille les étapes pour configurer AWS CloudWatch Events afin de déclencher des actions en fonction des changements d'état ou de métriques des ressources AWS, avec un accent sur les notifications par email. Les principales tâches sont les suivantes :

## Tâche 1 : Configuration de CloudTrail et d'un seau S3 pour enregistrer les événements CloudWatch
- Utiliser AWS CloudTrail pour enregistrer les événements CloudWatch.
- Configurer un seau S3 pour stocker ces événements.

## Tâche 2 : Création d'un sujet SNS pour les notifications par email
- Mettre en place un sujet SNS (Simple Notification Service) pour envoyer des notifications par email.

## Tâche 3 : Abonnement au sujet SNS
- S'abonner au sujet SNS en utilisant une adresse email valide.

## Tâche 4 : Création d'une règle CloudWatch Events
- Configurer une règle dans CloudWatch Events pour déclencher une notification SNS à chaque changement d'état d'une instance EC2.

## Tâche 5 : Test de la règle CloudWatch Events
- Effectuer des tests en arrêtant et en redémarrant une instance EC2.
- Vérifier la réception des emails de notification.

## Tâche 6 : Suppression de toutes les ressources
- Supprimer toutes les ressources créées au cours des étapes précédentes.

Suivez ces étapes pour mettre en place un système de notifications basé sur les événements CloudWatch, permettant une gestion proactive des changements d'état des instances EC2, avec la possibilité de tester et de vérifier les notifications par email.
