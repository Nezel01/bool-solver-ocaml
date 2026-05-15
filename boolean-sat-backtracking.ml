type eb = X of int | Vrai | Faux | Et of eb * eb| Ou of eb * eb | Non of eb;;

let valuation = [ (1, false) ; (2, false); (3, true)];;


let n = List.length valuation;;

let rec puissance a n =
  if n = 1 then
    a
  else
    a * puissance a (n-1);;

let rec evaluer a = match a with
  | X i -> List.assoc i valuation
  | Vrai -> true
  | Faux -> false
  | Et (p,q) -> evaluer p && evaluer q
  | Ou (p,q) -> evaluer p || evaluer q
  | Non b -> not (evaluer b);;

let rec evaluer_param a value= match a with
  | X i -> if(List.assoc i value = 0) then false else true
  | Vrai -> true
  | Faux -> false
  | Et (p,q) -> evaluer_param p value && evaluer_param q value
  | Ou (p,q) -> evaluer_param p value || evaluer_param q value
  | Non b -> not (evaluer_param b value);;


let expr = [(Ou(X 6,X 6),X 3) ; (Et(X 5, Non( Ou(X 3,X 6))),X 5);(Et(Faux, Non(
    Ou(X 2,Non(X 3)))),X 4)] ;;

let rec ecrire_Y y n =
  if n > 0 then
    Printf.printf "%d " y.(n - 1)
  else
    Printf.printf "\n";;

let rec ecrire_value value str= match value with
  | (b,i)::a ->
      if i = 0 then
        begin
          Printf.printf "(X%d , Faux) " b;
          ecrire_value a (str ^ "(X" ^ string_of_int b ^ " , Faux) ")
        end
      else
        begin
          Printf.printf "(X%d , True) " b;
          ecrire_value a (str ^ "(X" ^ string_of_int b ^ " , Vrai) ")
        end
  | [] ->
      Printf.printf "\n";
      str ^ "\n";;

let rec vect_to_list value y n =
  if n>0 then
    let h = (n, y.(n-1))::value in
    vect_to_list h y (n-1)
  else value;;

let rec print_list list n =
  for i = 0 to n do
    Printf.printf "%d " list.(i)
  done;;

let rec var_eq elem elm2 =
  match elem with
  | X j -> if X j = elm2 then true else false
  | Vrai -> false
  | Faux -> false
  | Ou(p ,q)-> (var_eq p elm2) || (var_eq q elm2)
  | Et(p,q)-> (var_eq p elm2) || (var_eq q elm2)
  | Non p -> (var_eq p elm2);;

let rec is_in elem list = match list with
  | [] -> false
  | a::rest ->
      if var_eq elem a then true else is_in elem rest;;

let rec var expr l = match expr with
  | X j -> if is_in (X j) l then l else (X j)::l
  | Vrai -> []
  | Faux -> []
  | Ou(p ,q)-> (var p l) @(var q l)
  | Et(p,q)-> (var p l) @(var q l)
  | Non p -> (var p l);;

let rec vars_couple (a, b) ans =
  let l1 = var a ans in
  let l2 = var b ans in
  l1 @ l2;;

let rec getVariables list ans = match list with
  | [] -> []
  | a::rest -> (vars_couple a ans) @ (getVariables rest ans);;

let rec variables_D list = match list with
  | [] -> []
  | a::rest ->
      if is_in a rest
      then variables_D rest
      else a :: variables_D rest;;

let variables exp = variables_D (getVariables exp []);;

let rec back n i y j exp comparatif list_oui =
  y.(i) <- j;

  if i = n - 1 then
    begin
      let value = vect_to_list [] y n in
      let k = (list_oui.(0) + 1) in
      list_oui.(0) <- k;

      let h = evaluer_param exp value in
      if (h = evaluer_param comparatif value) then
        begin
          list_oui.(k) <- 1
        end
    end
  else back n (i+1) y 0 exp comparatif list_oui;

  if j = 0 then
    back n i y 1 exp comparatif list_oui;;

let evalEquation n exp comparatif liste_bool=
  let y = Array.make n 0 in
  back n 0 y 0 exp comparatif liste_bool;;

let logicalAnd v1 v2 =
  let rec logicAnd vect1 vect2 i =
    if i < Array.length vect1 then begin
      vect1.(i) <- vect1.(i) land vect2.(i);
      logicAnd vect1 vect2 (i + 1)
    end else vect1
  in logicAnd v1 v2 1;;

let rec map_expr_to_vect list_exp n = match list_exp with
  | [] -> []
  | (a,b)::rest ->
      let l = Array.make ((puissance 2 n)+1) 0 in
      evalEquation n a b l;
      l :: (map_expr_to_vect rest n);;

let rec allLogicAnd vectlist exprList = match vectlist with
  | [] -> Array.make ((puissance 2 (List.length (variables exprList)))+1) 1
  | a::rest -> logicalAnd a (allLogicAnd rest exprList);;

let getLogicalIndexArray vector =
  let rec aux i acc =
    if i >= Array.length vector then acc
    else if vector.(i) = 1
    then aux (i + 1) (i :: acc)
    else aux (i + 1) acc
  in aux 0 [] |> List.rev |> Array.of_list;;

let rec enum_envi n i y j tab_str k =
  y.(i) <- j;

  if i = n - 1 then
    begin
      let value = vect_to_list [] y n in
      let l = k.(0) in
      tab_str.(l) <- ecrire_value value "";
      k.(0) <- (l + 1);
    end
  else enum_envi n (i+1) y 0 tab_str k;

  if j = 0 then
    enum_envi n i y 1 tab_str k;;

let rec bijection tab tab_str i =
  if i < (Array.length tab) then
    begin
      Printf.printf " %s" tab_str.(tab.(i) - 1);
      bijection tab tab_str (i+1)
    end;;

let afficher_var list =
  let rec aux = function
    | [] -> ()
    | [X i] -> Printf.printf "X%d" i
    | X i :: l ->
        Printf.printf "X%d, " i;
        aux l
    | _ -> ()
  in aux list;;

let rec i_appartient expr i = match expr with
  | X j -> if i = j then true else false
  | Vrai -> false
  | Faux -> false
  | Et (p,q) -> i_appartient p i || i_appartient q i
  | Ou (p,q) -> i_appartient p i || i_appartient q i
  | Non b -> i_appartient b i;;

let rec i_appartient_list_expr list_expr i = match list_expr with
  | [] -> false
  | (a,b)::l ->
      i_appartient a i || i_appartient b i || i_appartient_list_expr l i;;

let rec remplacer_i_par_j_expr expr i j = match expr with
  | X k -> if k = i then X j else X k
  | Vrai -> Vrai
  | Faux -> Faux
  | Et (p,q) -> Et(remplacer_i_par_j_expr p i j, remplacer_i_par_j_expr q i j)
  | Ou (p,q) -> Ou(remplacer_i_par_j_expr p i j, remplacer_i_par_j_expr q i j)
  | Non b -> Non(remplacer_i_par_j_expr b i j);;

let rec remplacer_i_j_list list_expr i j = match list_expr with
  | [] -> []
  | (a,b)::l ->
      ((remplacer_i_par_j_expr a i j),
       (remplacer_i_par_j_expr b i j))
      :: remplacer_i_j_list l i j;;

let rec recup_i_manquant list_expr n i =
  if i >= n then 0
  else
  if i_appartient_list_expr list_expr i = false then i
  else recup_i_manquant list_expr n (i+1);;

let rec maj_var_parcelle list_expr n h lb = match h with
  | [] -> (list_expr,lb)
  | (X i)::l ->
      if i > n then
        let a = recup_i_manquant list_expr n 1 in
        let b = remplacer_i_j_list list_expr i a in
        let c = (i,a)::lb in
        maj_var_parcelle b n l c
      else
        maj_var_parcelle list_expr n l lb
  | a -> (list_expr,lb);;

let maj_var list_expr =
  let h = variables list_expr in
  let n = List.length h in
  let (b,c) = maj_var_parcelle list_expr n h [] in
  (b,c);;

let rec info_bij_X bij = match bij with
  | [] -> []
  | (a, b)::l ->
      Printf.printf "X%d = X%d\n" b a;
      info_bij_X l;;

let main liste_expr =
  let list_expr, bij = maj_var liste_expr in

  let n = List.length (variables list_expr) in
  let y = Array.make n 0 in
  let m = puissance 2 n in
  let tab_str = Array.make m "" in
  let k = Array.make 1 0 in

  Printf.printf "La liste de variables est :\n";
  afficher_var (variables list_expr);

  Printf.printf "\nOn pose :\n";
  info_bij_X bij;

  Printf.printf "La liste a %d éléments, de :\n" m;

  enum_envi n 0 y 0 tab_str k;

  let vects = map_expr_to_vect list_expr n in
  let tab = getLogicalIndexArray (allLogicAnd vects list_expr) in

  Printf.printf "Seuls les %d des %d environements satisfont toutes les équations\n"
    (Array.length tab) m;

  bijection tab tab_str 0;;

let () = main expr;;