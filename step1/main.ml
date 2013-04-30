open Affichage
open CaseMap

let w = ref 0
let h = ref 0

let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " width height"

let parse argv =
  let dimension str =
    if !w = 0 then w := (int_of_string str)
    else if !h = 0 then h := (int_of_string str)
    else
      begin
        print_endline usage_msg;
        exit 1;
      end
  in
  let parse_one = function
    | x -> if x != Sys.argv.(0) then
      try dimension x with Failure _ -> begin
        print_endline usage_msg;
        exit 1;
      end
  in
  Array.iter parse_one Sys.argv

let () = begin
  parse Sys.argv;
  if !w = 0 || !h = 0 then
    print_endline usage_msg
  else
    begin
      let map = CaseMap.create !w !h in
      Affichage.draw map;
    end
end
