## La Nageuse Écarlate

Embarquez à bord de la Nageuse Écarlate, fière navire portant pavillon pirate.

Combattez en pleine mer, collectez des indices et débarquez dans les ports pour subtiliser les trésors de l'Orient.

Jeu réalisé en [ink](https://www.inklestudios.com/ink/) avec 492 mots pour la [Partim 500 2020](https://itch.io/jam/fr-partim-500-an-2020)  (Thème : débarquer)


## Jouer en ligne

[La Nageuse Écarlate sur itch.io](https://smwhr.itch.io/nageuse-ecarlate)


## Jouer en local

Récupérez le code exporté du dossier `ecarlate_web` puis lancez votre serveur préféré depuis le dossier et rendez-vous sur http://localhost:8001

### Avec php
```
php -S 0.0.0.0:8001 -t .
```

### Avec python
```
python3 -m http.server 8001
```

## Modifier
Utilisez inky pour ouvrir le fichier `ecarlate.ink` et ses dépendances.

### Architecture du ink
* `ecarlate.ink` : hub général
* `ecarlate/opensea.ink` : gestion des rencontres / combats / knowledge
* `ecarlate/debarquer.ink` : gestion des ports / trésors
* `ecarlate/functions.ink` : fonctions support d'affichage / knowledge

## Licence 
Texte et gameplay :
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

Code :
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


## Credits & thanks

* Ink programming language : [Inkle](https://www.inklestudios.com/ink/)
* Inky 
* Background image : [A threemaster with the Amsterdam coat-of-arms, with other vessels, in a storm, Ludolf Bakhuizen](https://commons.wikimedia.org/wiki/File:Ludolf_Bakhuizen_-_A_threemaster_with_the_Amsterdam_coat-of-arms,_with_other_vessels,_in_a_storm.jpg)[(source)](https://www.christies.com/lot/lot-ludolf-backhuysen-emden-1630-1708-amsterdam-a-5063435/)
* Partim500 organizer : [Feldo](https://feldo.itch.io/)
