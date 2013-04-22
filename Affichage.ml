open Case

let _ = Sdl.init [`VIDEO]

let init () = ()

let draw map w =
  let rec aff i map = match i, map with
    | _, [] -> ()
    | i, _ when i <= 0 -> Printf.printf " _";
                          if (i mod w) = 0 then print_endline "";
                          aff (i + 1) map
    | i, c::r -> begin
                if (Case.get_id c) mod w = 1 then
                  if (List.exists ((=) ((Case.get_id c) - 1)) (Case.get_door c))
                  then print_char ' ' else print_char '|';
                if (List.exists ((=) ((Case.get_id c) + w)) (Case.get_door c))
                then print_char ' ' else print_char '_';
                if (List.exists ((=) ((Case.get_id c) + 1)) (Case.get_door c))
                then print_char ' ' else print_char '|'
              end;
              if (i mod w) = 0 then print_endline "" ; aff (i + 1) r
  in
  aff ((-w) + 1) map
