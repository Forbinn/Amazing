open Affichage
open Case

let w = ref 0
let h = ref 0
let forme = ref 4

let args = [
    ("--square", Arg.Unit (fun () -> forme := 4), "Square mode (default)");
    ("--hexagonal", Arg.Unit (fun () -> forme := 6), "Hexagone mode");
]
let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " w h [-t] [--square | --hexagonal]"
let other s = try
                if !w = 0 then w := (int_of_string s)
                else if !h = 0 then h := (int_of_string s)
                else
                  begin
                    Arg.usage args usage_msg;
                    exit 1
                  end
              with
              Failure _ -> begin
                Arg.usage args usage_msg;
                exit 1
              end

let () = begin
  Arg.parse args other usage_msg;
  if !w = 0 || !h = 0 then
    Arg.usage args usage_msg
  else
    let screen = Affichage.init !w !h in
    let c1 = Case.create 1 1 in
    let c2 = Case.create 2 2 in
    let map = c1::c2::(Case.create 3 3)
    ::(Case.create 4 4)::(Case.create 5 5)::(Case.create 6 6)
    ::(Case.create 7 7)::(Case.create 8 8)::(Case.create 9 9)::[] in

    Case.add_door c1 2;
    Case.add_door c2 1;
    Affichage.draw map !w screen;
    Affichage.run ();
    Affichage.quit ()
end
