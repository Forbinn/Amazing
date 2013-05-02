open Case

type map =
  {
    width: int ref;
    height: int ref;
    cases: case list ref;
  }

(* a changer pour le passage en hexagonal *)

let rec get_random_side id width height =
  let n = (Random.int 4)
  in let (x, y) =
    if n = 0 then (0, -1)
    else if n = 1 then (1, 0)
    else if n = 2 then (0, 1)
    else (-1, 0)
    in let (a, b) = ((id mod width) + x, (id / width) + y)
      in if (a < 0) || (a >= width) || (b < 0) || (b >= width) then
        get_random_side id width height
      else b * width + a

let get_ref_case_from_id cases id =
  ref (List.nth cases id)

let generate width height =
  let rec create_cases cases n =
    if n < 0 then cases
    else create_cases ((Case.create n n)::cases) (n - 1)
  and color_cases cases color doors path = match doors with
    | (id::r) -> let case = !(get_ref_case_from_id cases id)
      in Case.change_color case color;
      if not (List.exists ((=) id) path) then
        color_cases cases color (Case.get_door case) (id::path)
    | [] -> ()
  (*and color_cases cases color doors = 
    let rec create_case_list cases doors l = match doors with
      | (id::r) -> create_case_list cases r
        (if (List.exist ((=) id) l) then l else id::l)
      | [] -> l
    and fill_case_list color l = match l with
      | (id::r) -> Case.change_color !(get_ref_case_from_id cases id) color;
        fill_case_list color r
      | [] -> ()*)
  and open_doors cases n =
    let is_ok cases =
      let rec is_ok_aux cases color = match cases with
        | (c::r) -> if (Case.get_color c) <> color then false
          else is_ok_aux r color
        | [] -> true
      in is_ok_aux cases (Case.get_color (List.nth cases 0))
    in if (is_ok cases) = true then cases
    (*in if n = 0 then cases*)
    else let a_id = (Random.int (width * height))
      in let b_id = (get_random_side a_id width height)
        in let (a, b) = (get_ref_case_from_id cases a_id, get_ref_case_from_id cases b_id)
        in (*Printf.printf "[%d-%d]\n" a_id b_id;*) if (Case.get_color !a) <>
        (Case.get_color !b)
            (*&& not (List.exists ((=) a_id) (Case.get_door !b))*) then
              begin 
              Printf.printf "<";
              Printf.printf "%d:" a_id;
              List.iter (Printf.printf "%d,") (Case.get_door !a);
              Printf.printf ">";
            Printf.printf "%d.%d\n" (Case.get_color !a) (Case.get_color !b);
              Case.add_door !a b_id;
              Case.add_door !b a_id;
              color_cases cases (Case.get_color !a) (Case.get_door !b) [];
              open_doors cases (n - 1)
              end
            else open_doors cases n
  in open_doors (create_cases [] (width * height - 1)) (width * height)

(*let generate width height =
  let rec create_cases cases n =
    if n = 0 then cases
    else create_cases ((Case.create n n)::cases) (n - 1)
  and create_list l size =
    if size = 0 then l
    else create_list ((size - 1)::l) (size - 1)
  and randomize_list nl l size =
    let rec remove l n = match l with
      | (i::r) -> if n = 0 then r else i::(remove r (n - 1))
      | [] -> []
    in match l with
      | (i::r) -> let x = (Random.int size)
                  in randomize_list ((List.nth l x)::nl) (remove l x) (size - 1)
      | [] -> nl
  and color_cases cases color doors path = match doors with
    | (id::r) -> let case = !(get_ref_case_from_id cases id)
      in Case.change_color case color;
      if not (List.exists ((=) id) path) then
        color_cases cases color (Case.get_door case) (id::path)
    | [] -> ()
  and open_doors cases l = match l with
    | (i::r) -> let a_id = i
                in let b_id = (get_random_side a_id width height)
                in let a = !(get_ref_case_from_id cases a_id)
                   and b = !(get_ref_case_from_id cases b_id)
                  in if (Case.get_color a) <> (Case.get_color b) then
                    begin
                      Case.add_door a b_id;
                      Case.add_door b a_id;
                      color_cases cases (Case.get_color a) (Case.get_door b) [];
                    end;
                    open_doors cases r
    | [] -> ()
  in let l = randomize_list []
             (create_list [] (width * height)) (width * height)
     and c = create_cases [] (width * height)
    in begin
      open_doors c l;
      c;
    end*)

let create width height =
  {
    width = ref width;
    height = ref height;
    cases = ref (generate width height);
  }

let get_width map =
  !(map.width)

let get_height map =
  !(map.height)

let get_case_list map =
  !(map.cases)
