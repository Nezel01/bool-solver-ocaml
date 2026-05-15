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




FONCTIONS ET TESTS UNITAIRES

i) variables

Syntaxe : variables (liste_d’équations)

Cette fonction prend en argument une liste de couples d’équations de la forme :
[(Ou(X 2, X 4), Vrai);
 (Non (Et (X 2, Et (X 4, X 2))), Vrai)]

Elle renvoie la liste des variables sans doublons sous la forme :
[X i, ..., X j]

où i et j sont des entiers.

Exemple :
[X 2; X 4]


Fonctions utilisées :

- var (expr) (accumulateur)
Prend une expression (ex : Ou(X 2, X 4)) et renvoie toutes les variables présentes avec doublons.

- vars_couple (a, b) (accumulateur)
Prend un couple d’expressions et renvoie toutes les variables présentes dans a et b avec doublons.

- getVariables (liste de couples)
Parcourt chaque couple et concatène toutes les variables avec doublons.

- variables_D (liste de variables)
Supprime les doublons dans la liste de variables.


evaluer_param a value :

Prend une expression a et une liste value contenant les valeurs des variables.
Renvoie la valeur de vérité de l’expression selon l’environnement donné.


ii) back n i y j exp comparatif list_oui

Fonction principale de backtracking utilisée pour trouver les solutions.

Paramètres :
- n : nombre de variables
- i : index du backtracking
- y : tableau représentant l’environnement courant
- j : valeur 0 ou 1
- exp et comparatif : expressions à comparer (A = B)
- list_oui : tableau de taille 2^n + 1

Ce tableau est modifié pendant l’exécution et devient le vecteur caractéristique final.


iii) evalEquation

evalEquation n exp comparatif liste_bool

Cette fonction appelle back en initialisant le tableau qui stockera les résultats.


iv) map_expr_to_vect

map_expr_to_vect (liste d’équations) (n)

Applique evalEquation à chaque équation et génère une liste de vecteurs caractéristiques.


v) logicalAnd

logicalAnd vect1 vect2

Renvoie le ET logique entre deux vecteurs.


vi) allLogicAnd

allLogicAnd vectlist exprList

Applique un ET logique global sur tous les vecteurs caractéristiques.


vii) getLogicalIndexArray

getLogicalIndexArray vector

Prend un vecteur et renvoie un tableau contenant les indices où la valeur vaut 1.


viii) enum_envi

enum_envi n i y j tab_str k

Fonction de backtracking qui énumère toutes les combinaisons possibles des variables.

Paramètres :
- n : nombre de variables
- i : index du backtracking
- y : tableau représentant l’environnement courant
- j : valeur 0 ou 1
- tab_str : tableau de chaînes
- k : compteur

Permet d’énumérer tous les environnements possibles.


ix) bijection

bijection tab tab_str i

Affiche les environnements correspondant aux indices où tab.(i) = 1.

- tab : vecteur final des solutions
- tab_str : représentation des environnements


x) i_appartient expr i

Vérifie si X i appartient à une expression.
Retourne true ou false.


xi) i_appartient_list_expr

Applique i_appartient sur une liste d’expressions.


xii) remplacer_i_par_j_expr

Remplace X i par X j dans une expression.


xiii) remplacer_i_j_list

Applique le remplacement sur une liste d’expressions.


xiv) recup_i_manquant

recup_i_manquant list_expr n i

Retourne le premier indice manquant dans [1, n].

Exemple :
X1, X3, X4  →  retourne 2


xv) maj_var_parcelle

Renomme les variables pour qu’elles soient continues dans [1, n].

Exemple :
X1, X2, X6, X5 → X1, X2, X3, X4

Retourne :
- nouvelle expression
- liste des correspondances


xvi) maj_var

Appelle maj_var_parcelle et retourne son résultat.


xvii) info_bij_X

Affiche les correspondances :
Xb = Xa


xviii) main

Fonction principale :
- récupère les expressions
- calcule les variables
- génère les environnements
- calcule les solutions
- affiche les résultats
Fonctions et test unitaire
