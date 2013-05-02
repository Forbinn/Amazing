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
    in if (a < 0) || (a >= width) || (b < 0) || (b >= height) then
        get_random_side id width height
      else b * width + a

let get_ref_case_from_id cases id =
  ref (List.nth cases id)

let generate width height =
  let rec create_cases cases n =
    if n < 0 then cases
    else create_cases ((Case.create n n)::cases) (n - 1)
  and color_cases cases color doors path = match doors with
  | (id::r) -> let case = (get_ref_case_from_id cases id)
      in if not (List.exists ((=) id) path) then
        begin
          Case.change_color !case color;
          color_cases cases color (Case.get_door !case) (id::path)
        end;
      (* ACHIEVEMENT UNLOCKED *)
      color_cases cases color r path
    | [] -> ()
  and open_doors cases =
    let is_ok cases =
      let rec is_ok_aux cases color = match cases with
        | (c::r) -> if (Case.get_color c) <> color then false
          else is_ok_aux r color
        | [] -> true
      in is_ok_aux cases (Case.get_color (List.nth cases 0))
    in if (is_ok cases) = true then cases
    else let a_id = (Random.int (width * height))
      in let b_id = (get_random_side a_id width height)
      in let (a, b) = (get_ref_case_from_id cases a_id, get_ref_case_from_id cases b_id)
        in if (Case.get_color !a) <> (Case.get_color !b)
            && not (List.exists ((=) a_id) (Case.get_door !b)) then
            begin 
              Case.add_door !a b_id;
              Case.add_door !b a_id;
              Case.change_color !b (Case.get_color !a);
              color_cases cases (Case.get_color !a) (Case.get_door !b) [a_id];
            end;
            open_doors cases
  in open_doors (create_cases [] (width * height - 1))

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
