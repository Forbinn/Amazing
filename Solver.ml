let solve map a_id b_id = 
    let cases = CaseMap.get_case_list map in
    let (case_a, case_b) = (List.nth cases a_id, List.nth cases b_id) in
    let find_path case path =
        let doors = Case.get_door case in
        let rec parcour_door doors path = match doors with
            | [] -> []
            | door::r -> let found = find_path (List.nth cases door) door::path in
                         if found = [] then
                            parcour_door r path
                         else
                            found in
        if (Case.get_id case) = b_id then
            path
        else
            parcour_door (Case.get_door case) path
    in
        find_path case_a a_id::[]
