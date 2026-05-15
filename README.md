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





Fonctions et test unitaire

i) variables :
Syntax : variables (liste_d’equation)
Cette fonction prend en argument la liste de couples (d’équations) de la forme [(Ou(X 2, X 4), Vrai) ;
(Non (Et (X 2, Et (X 4, X 2))), Vrai) ] donne par l’utilisateur et renvoi la liste de variables sans doublons
de la forme [X i,...., X j] avec i,j des nombres réels. Elle renverra ici [X 2, X 4]. Pour effectuer ce travail
elle fait appel aux fonctions ;
- var (param1 : une expression) (param2 : un accumulateur initialement vide)
Cette fonction prend le une expression quelconque de la forme Ou(X 2, X 4) et renvoie toutes
les variables dans cette expression avec doublons dans la liste
- vars_couple (parametre 1 : le couple (a, b) ) (param2 un accumulateur)
Cette fonction prend un couple d’expression et renvoi toutes les variables dans l’expression a
et l’expression b avec doublons
- getVariables (parametre1 : liste de couple d’expression) (parametre 2 : une liste vide)
Cette fonction boucle sur chaque couple du parametre1 et renvoi la concaténation de la liste
de variables présente dans chaque couple avec doublons.
- variables_D (parametre1 : liste de couple d’expression) :
Cette fonction boucle sur la liste des variables avec doublons (parametre1) et renvoi une liste
de variables sans doublons.

- evaluer_param a value : prend une expression a avec chaque valeur de (x i) renseigné dans
value et renvoie la valeur de vérité de l'expression selon les valeurs de valeur.
ii) back n i y j exp comparatif list_oui :
fonction principale de backtracking utilisé pour la recherche des solutions, elle prend en
argument :
. n : le nombre de variables
. i : l'incrementeur du backtracking
. j : une variable pour simuler une boucle sur le vecteur caractéristique de la fonction de
backtracking
. exp et comparatif : les expressions à évaluer et à comparer, concrètement pour chaque
couple (a,b) de la liste d'expressions expr = a et comparatif = b.
. list_oui : est un tableau de 0 de taille 2 puissance n + 1 a insérer en paramètre qui sera
modifié pour devenir a la fin de l'appel de la fonction le vecteur caractéristique a retourner.
iii) evalEquation n exp comparatif liste_bool : fonction qui appelle la fonction de
backtracking "back" avec ici liste_bool le tableau qui sera inséré dans "back" au nom de
list_oui.
iv) map_expr_to_vect (param1 :liste d’equations) (n : le nombre de variable)
cette fonction fait appel a evalEquation et génère une liste de vecteur caractéristique
pour chaque équation
v) logicalAnd (param1:vecteur1) (param2:vecteur2)
Fonction qui renvoie le vecteur correspondant au &-logique entre vecteur1 et vecteur2.
vi) allLogicAnd (param1 :vectlist) (param2 :exprList)
fonction qui renvoi le &-logique de tous les vecteurs caractéristique dans vectlist la liste
de vecteur caractéristique.
vii) getLogicalIndexArray (parameter :vector)
Fonction qui prend en argument un vecteur et renvoi un tableau d’indices qui valent 1
dans ce vecteur.
viii) enum_envi n i y j tab_str k : fonction de backtracking pour énumérer toutes les
possibilités que peuvent prendre les variables, autrement dit elle affiche
l'environnement. De même ici n est le nombre de variables, i est l'incrémenteur de
backtracking, j pour simuler la boucle, y est un tableau de taille n (le vecteur
caractéristique propre à la fonction pour se rappeler quel variable ab quel valeur de
vérité) et enfin tab_str pour "tableau de string" est un tableau de taille 2 puissance 2 qui
stockera les affichage de l'environnement et qui sera réutilisé par la fonction bijection.
ix) bijection tab tab_str i : est la fonction qui récupère le vecteur final représentant
l'ensemble des solutions (c'est le paramètre tab), elle prend également le
tab_str introduit précédemment ( cela permet de ne pas avoir à refaire une opération de
backtracking) et pour chaque valeur 1 de tab elle affiche selon l'indice correspondante de
tab_str l'affichage correspondante de cet solution, i est un incrémenteur utilisé pour
boucler.
x) i_appartient expr i : vérifie si dans une expression donnée il existe une variable X i, elle
renvoie alors true, sinon false.

xi) i_appartient_list_expr list_expr i : applique i_appartient dans chaque expressions de
list_expr
xii) remplacer_i_par_j_expr expr i j : remplace dans une expression donné tous les (X i) par
des (X j)
xiii) remplacer_i_j_list list_expr i j : applique « remplacer_i_par_j_expr » pour chaque
expressions de list_expr.
xiv) recup_i_manquant list_expr n i : Cette fonction retourne le premier i manquant de
l’expression, cad le premier i tel que il n’existe pas de variable (X i) avec i appartenant a
l’ensemble [1, n] . La variable n correspond au nombre de variables différentes dans
list_expr, list_expr est la liste des expressions et i est un incrémenteur pour boucler la
fonction de 1 à n.
Exemple : considérons que list_expr possède 3 variables nommé X1, X3 et X4, alors on a ici n
= 3 (on rappelle n est le nombre de variables différentes présent dans list_expr), ici la
fonction renvoie 2 car 2 appartient a [1,3] et 2 il n’y a pas de variables (X 2) présente dans
list_expr.
xv) maj_var_parcelle list_expr n h lb : cette fonction récupère une liste d’expressions avec
des variables a indice pouvant dépasser n, et les renomme de sorte a ce que pour toute
variable (X i) i soit compris dans l’intervalle [1,n], si par exemple on a les variables (X1,
X2, X6, X5) la fonction les renommera par exemple en (X1, X2, X3, X4). List_expr est une
fois encore la liste des expressions, n est le nombres de variables différentes présent
dans list_expr, variable est la liste des variables différentes renvoyé par la fonction
« variables » donc sous le format [X 1 ; X 2 ; X 4...] et enfin lb est une liste vide qui a
chaque changement d’indice sera renseigné par le couple correspondant, si par exemple
on change X5 en X3 alors on ajoute a lb (pour liste bijection) le couple (5,3). La fonction
renvoie le couple de la forme (b,c) où b est la nouvelle expression et c est la liste des
bijection (c’est la liste lb en fin de programme).
xvi) maj_var list_expr : appelle la fonction « maj_var_parcelle » et renvoie le couple (b,c)
retourné par la fonction « maj_var_parcelle » appelé.
xvii) info_bij_X bij : récupère en paramètre la liste de couple bij (qui est la liste des bijection
retourné par la fonction « maj_var ») et affiche pour chaque couple (a,b) la ligne : Xa =
Xb
xviii) main liste_expr : Fonction finale et principale, elle récupère la liste d’expression
liste_expr et répond a la problématique de départ.
