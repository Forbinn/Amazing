open Affichage

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
    (*
  else
     * Generer la map et affichage
     * let () = Affichage.draw map w
     *)
end
