type case =
  {
    id            : int;
    mutable color : int;
    mutable door  : int list;
  }

let create id color = {id = id ; color = color ; door = []}

let change_color c newColor = c.color <- newColor

let add_door c numDoor = c.door <- (numDoor::c.door)

let get_id c = c.id

let get_color c = c.color

let get_door c = c.door

let get_nb_door c = List.length c.door
