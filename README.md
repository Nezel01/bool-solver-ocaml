# bool-solver-ocaml
Solveur d’équations booléennes en OCaml basé sur une approche par backtracking (brute force), permettant d’énumérer et de filtrer toutes les solutions d’un système logique.
Solveur d’équations booléennes (Backtracking)

========================
Présentation
========================

Ce projet implémente un solveur d’équations booléennes en OCaml.

L’objectif est de calculer l’ensemble des solutions d’un système d’équations logiques de la forme :

    A = B

où A et B sont des expressions booléennes construites à partir de variables et d’opérateurs logiques.

========================
Principe de fonctionnement
========================

1) Représentation des expressions

Les expressions booléennes sont définies par un type :

- X i : variable
- Vrai : vrai
- Faux : faux
- Et (a,b) : ET logique
- Ou (a,b) : OU logique
- Non a : négation


2) Évaluation des expressions

Deux fonctions permettent d’évaluer une expression :

- evaluer : avec une valuation fixe
- evaluer_param : avec une valuation générée dynamiquement


3) Génération des valuations

Le programme génère toutes les combinaisons possibles des variables grâce à un backtracking.

Chaque combinaison est testée sur les équations.


4) Construction d’un vecteur de résultats

Pour chaque équation :

- toutes les valuations sont testées
- le résultat est stocké sous forme de 0 ou 1 dans un vecteur


5) Intersection des solutions

Tous les vecteurs sont combinés avec un ET logique global afin de ne garder que les solutions valides pour toutes les équations.


6) Affichage

Le programme affiche :

- la liste des variables
- les correspondances de renommage éventuelles
- toutes les combinaisons possibles
- les solutions qui satisfont toutes les équations


========================
Exemple
========================

Entrée :

(Ou(X 2, X 4), Vrai)
(Ou(Et(X 2, Non(X 4)), Et(X 6, Non(X 2))), X 4)
(Non(Et(X 2, Et(X 4, X 2))), Vrai)


Sortie :

- Liste des variables
- Toutes les combinaisons possibles
- Nombre de solutions valides


========================
Structure du projet
========================

- Définition des expressions booléennes
- Fonctions d’évaluation
- Génération des combinaisons (backtracking)
- Calcul des solutions
- Affichage final


========================
Objectif pédagogique
========================

Ce projet permet de comprendre :

- la logique booléenne
- le backtracking (énumération exhaustive)
- la manipulation de structures récursives en OCaml
- la résolution de problèmes SAT simplifiés


========================
Auteur
========================

Projet réalisé dans un cadre d’apprentissage OCaml / logique / algorithmes.
