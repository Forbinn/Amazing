open Affichage
open CaseMap

let w = ref 0
let h = ref 0

let generator = ref CaseMap.create

let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " width height [fast]"

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
  in let args = ref Sys.argv
    in if (Array.length !args) = 4 then
      if Sys.argv.(3) = "fast" then
        begin
          generator := CaseMap.create_fast;
          args := Array.sub Sys.argv 0 3
        end
      else
        begin
          print_endline usage_msg;
          exit 1;
        end;
  Array.iter parse_one !args

let () = begin
  parse Sys.argv;
  if !w = 0 || !h = 0 then
    print_endline usage_msg
  else
    begin
      Random.self_init ();
      let screen = Affichage.init !w !h in
      let map = !generator !w !h in
      Affichage.draw_soluce (Solver.solve map 0 (!w * !h - 1)) screen !w;
      Affichage.draw map screen;
      Affichage.run (function coord ->
        let a = List.nth coord 0 and b = List.nth coord 1
        in let (ax, ay) = a
           and (bx, by) = b
          in Printf.printf "%d %d -> %d %d\n" ax ay bx by;
          Affichage.clear screen;
          Affichage.draw_soluce (Solver.solve map (ax + ay * !w) (bx + by * !w)) screen !w;
          Affichage.draw map screen;
          ()
      );
      Affichage.quit ();
    end
end
