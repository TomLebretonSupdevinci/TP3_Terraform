# TP Terraform

Ce projet nous permet de découvrir l'utilisation de l'outils Terraform. Il nous est demandé de créer un prototype pour la migration vers de le cloud de l'infrastructure d'un client.
Nous devons donc utilisé, sur une machine Linux Azure, Terraform pour créer :

* Un groupe de ressource (azurerm_resource_group)
* Un compte de stockage (azurerm_storage_account)
* Une VM linux ubuntu 22 LTS (azurerm_linux_virtual_machine), accessible

Pour cela nous allons effectuer les étapes suivantes : 

* Création d'une machine virtuelle (Node_Terraform) sur Azure sur laquelle Terraform sera installé pour déployer notre infrastructure.
* Installation d'Azure CLI
* Installation de Terraform
* Création des fichiers Terraform :
  * main.tf (Création du Resource Group)
  * sa.tf (Création du compte de stockage)
  * vm.tf (Création de la VM)
* Lancement de terraform afin de créer les ressources sur Azure

-----------------------------------

## Prérequis

- Git 
- Compte Azure
- Machine virtuelle Ubuntu 22.04

-----------------------------------

#### 1. Installation d'Azure CLI

Instalation en une seule commande : 

```curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash```

#### 2. Se connecter à Azure

```az login```

Ici il faut indiquer un token sur une page web Azure, qui permettra de lié Terraform à notre compte Azure.

#### 3. Récupération du Subscription ID

```az account list --query "[].{name:name, subscriptionId:id}"```

#### 4. Création d’un Service Principal

```az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<YourSubscriptionId>"```

Il est ici important de récupérer les données suivantes : 

* "appId" qui correspondra dans la suite à ARM_CLIENT_ID
* "password" qui correspondra dans la suite à ARM_CLIENT_SECRET.
* "tenant" qui correspondra dans la suite à ARM_TENANT_ID.

#### 5. Set des variables d'environnement

Il est maintenant nécéssaire de set les variables d'environnement avec les données récupérés précédement : 

export ARM_SUBSCRIPTION_ID= SubscriptionId
export ARM_CLIENT_ID= appI
export ARM_CLIENT_SECRET= password
export ARM_TENANT_ID= tenant 

------------------------------------

## Installation de Terraform

Lien vers la documentation Terraform (installation [ici](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))

------------------------------------
## Création des fichiers Terraform :

#### 1. main.tf (Création du Resource Group)

Dans ce fichier sera présent la configuration pour la création de Resource Group. 
(accès à la documentation spécifique à Resource Group [ici](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group))

#### 2. sa.tf (Création du Resource Group)

Dans ce fichier sera présent la configuration pour la création du compte de stockage. 
(accès à la documentation spécifique à storageçaccount [ici](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group))

#### 1. vm.tf (Création du Resource Group)

Dans ce fichier sera présent la configuration pour la création des ressources de la machine virtuelle. 

(accès à la documentation spécifique à Linux virtual machine [ici](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)

#### 3. Créer la WebApp sur Azure

Lien vers la documentation Azure consacré à la création d'une application web : [ici](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

Se rendre dans le centre de déploiement et connecter le compte GitHub lié au projet

## Lancement de terraform afin de créer les ressources sur Azure

Nous allons donc tester la création des ressources, pour éviter les erreurs et facilité le debug en cas de besoin, il est conseillé de lancer étape par étape : 

Validé le fonctionnement de la création du groupe de ressource, puis de la création du compte de stockage et enfin de la machine virtuelle.

## Commandes Terraform courantes: 

* ```terraform init```
    * Initialise un répertoire de travail Terraform, installant les plugins nécessaires pour la gestion des ressources définies dans les fichiers de configuration.


* ```terraform plan```
    * Crée un plan d'exécution, montrant quelles actions Terraform effectuera pour changer l'état de vos ressources pour correspondre à la configuration définie. C'est un bon moyen de valider les changements avant de les appliquer.


* ```terraform apply```
    * Applique les changements définis par un plan d'exécution Terraform. Cette commande modifiera réellement les ressources dans votre fournisseur de services pour qu'elles correspondent à votre configuration.


* ```terraform destroy```
    * Supprime toutes les ressources définies dans la configuration Terraform, nettoyant ainsi l'environnement géré par Terraform.


## Auteurs

- Boulen Pierre
- Lebreton Tom
