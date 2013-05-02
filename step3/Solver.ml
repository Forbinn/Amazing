open Case
open CaseMap

let solve map a_id b_id =
  let cases = CaseMap.get_case_list map
  in let (a, b) = (List.nth cases a_id, List.nth cases b_id)
    in let rec find_path doors path = match doors with
      | (id::r) -> let case = (List.nth cases id)
      in if (Case.get_id case) = b_id then begin Printf.printf "FOUND"; path end
                   else begin
                     if not (List.exists ((=) id) path) then
                       find_path (Case.get_door case) (id::path)
                     else []
                   end;
                   find_path r path
      | [] -> []
  in find_path (Case.get_door a) [a_id]
