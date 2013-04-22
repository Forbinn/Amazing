open Case
open Affichage

let c2 = create 2 2

let () = Case.add_door c2 1
let () = Case.add_door c2 3
let () = Case.add_door c2 5

let c = [(create 1 1);
         c2;
         (create 3 3);
         (create 4 4);
         (create 5 5);
         (create 6 6);
         (create 7 7);
         (create 8 8);
         (create 9 9)]

let () = Affichage.draw c 3
