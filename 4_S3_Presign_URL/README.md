# Génération d'une URL pré-signée S3 avec CloudShell

Ce document a pour objectif d'expliquer le processus de génération d'une URL pré-signée S3 en utilisant CloudShell. Cette URL permet un accès temporaire à un objet stocké dans un seau S3. Les principales tâches sont les suivantes :

## Objectif du document
- Explication du concept d'URL pré-signée S3 et de son utilisation pour accéder à un objet S3 pendant une durée limitée.

## Tâche 1 : Création d'un seau S3
- Création d'un seau S3 avec un nom unique et une région spécifique.
- Désactivation des ACL pour la propriété des objets.

## Tâche 2 : Téléchargement d'un fichier dans un seau S3
- Téléchargement d'un fichier image depuis l'ordinateur local ou un lien fourni.
- Copie de l'URI S3 du fichier téléchargé.

## Tâche 3 : Création d'un environnement dans CloudShell
- Accès à CloudShell, un service fournissant un terminal basé sur le navigateur pour exécuter des commandes AWS.
- Attente de la création de l'environnement avant d'utiliser le terminal.

## Tâche 4 : Exécution de la commande S3 pré-signée et test de la sortie
- Utilisation de la syntaxe pour exécuter la commande AWS générant une URL pré-signée S3 à partir de l'URI S3 du fichier.
- Spécification d'une durée d'expiration en secondes.
- Copie de l'URL générée et test en la collant dans un nouvel onglet du navigateur. L'URL n'est valide que pendant la durée spécifiée.

