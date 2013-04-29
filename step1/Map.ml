open Case

type map =
  {
    width: int ref;
    height: int ref;
    cases: case list ref;
  }

let generate width height = []

let create width height =
  {
    width = ref width;
    height = ref height;
    cases = ref (generate width height);
  }

let get_case_list map =
  !(map.cases)
