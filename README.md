Problèmes de sécurité initiaux:


 - Fuites d'info: Un mode debug permet d’obtenir de nombreuses informations

 - XSS reflect: Le formulaire de recherche est exposé à une XSS reflected.

 - XSS stored: Le formulaire de contact est exposé à une XSS stored.

 - SQLi: Le formulaire d'authentification est exposé à une SQLi

 - Insecure reference: Il est possible de consulter le panier des autres visiteurs.

 - Contrôle d'accès: Il est possible de commander des produits au négatif afin de compenser les commandes en positif (réduction du montant du panier)

 - Fuite de données: L'adresse de la console d'administration est indiquée dans le code source client

 - Contrôle d'accès: Il est possible d'accéder à la console d'administration sans authentification

 - Requête prédictible (CSRF): Il est possible de voler le compte d'un utilisateur (et l'administrateur) via une requête forgée (chang. mot de passe)

 - SQLi: La protection du formulaire de recherche avancée n’est pas suffisante

 - Absence de protection: Les mots de passe des utilisateurs sont stockés en clair.


Le but consiste à la correction des vulnérabilités indiquées.