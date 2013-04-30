open Case
open CaseMap

(*
 * Fonction servant a dessiner le labyrinthe
 * (en texte uniquement)
*)
let draw map =
  let w = CaseMap.get_width map in
  let maplist = CaseMap.get_case_list map in
  let rec draw_aux i map = match i, map with
    | _, [] -> ()
    | i, _ when i <= 0 -> Printf.printf " _";
                          if (i mod w) = 0 then print_endline "";
                          draw_aux (i + 1) map
    | i, c::r -> begin
                if (Case.get_id c) mod w = 1 then
                  if (List.exists ((=) ((Case.get_id c) - 1)) (Case.get_door c))
                  then print_char ' ' else print_char '|';

                if (List.exists ((=) ((Case.get_id c) + w)) (Case.get_door c))
                then print_char ' ' else print_char '_';

                if (List.exists ((=) ((Case.get_id c) + 1)) (Case.get_door c))
                then print_char ' ' else print_char '|';

                if (i mod w) = 0 then print_endline "";
                draw_aux (i + 1) r
              end
  in
    draw_aux ((-w) + 1) maplist
