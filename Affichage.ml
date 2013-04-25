open Case

(*
 * Fonction servant a initialiser la SDL si l'option a ete choisi
*)
let init aff =
  if aff = "sdl" then
    begin
      Sdl.init [`VIDEO];
      Sdlevent.enable_events Sdlevent.all_events_mask;
    end

(*
 * Fonction servant a decharger la SDL
*)
let quit aff =
  if aff = "sdl" then Sdl.quit ()

(*
 * Fonction servant a dessiner le labyrinthe
 * (en texte uniquement)
*)
let draw map w =
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
    begin
      draw_aux ((-w) + 1) map
    end
