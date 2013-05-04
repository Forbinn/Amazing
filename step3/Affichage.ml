open Case
open CaseMap

(*
 * init de la SDL
 *)
let init w h =
  begin
    Sdl.init [`VIDEO];
    let screen = Sdlvideo.set_video_mode (w * 20 + 1) (h * 20 + 1) [] in
    Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen Sdlvideo.black);
    Sdlvideo.flip screen;
    screen
  end

let quit () = Sdl.quit ()

let mouse_coord = ref []

(*
 * Fonction qui wait la touche escape ou la fermeture de la fenetre
 *)
let rec run cbk = match Sdlevent.wait_event () with
  | Sdlevent.MOUSEBUTTONDOWN e ->
      mouse_coord := ((e.Sdlevent.mbe_x / 20), (e.Sdlevent.mbe_y / 20))::!mouse_coord;
      if (List.length !mouse_coord) = 2 then
        begin
          cbk !mouse_coord;
          mouse_coord := []
        end;
      run cbk
  | Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> ()
  | Sdlevent.QUIT -> ()
  | _ -> run cbk


let blit_img x y img screen =
  let pos = Sdlvideo.rect y x 0 0 in
  Sdlvideo.blit_surface ~dst_rect:pos ~src:img ~dst:screen ()

let blit_case c screen w img_h img_v =
  begin
    if not (List.exists ((=) ((Case.get_id c) - 1)) (Case.get_door c))
    then blit_img (((Case.get_id c) / w) * 20) (((Case.get_id c) mod w) * 20) img_v screen;

    if not (List.exists ((=) ((Case.get_id c) - w)) (Case.get_door c))
    then blit_img (((Case.get_id c) / w) * 20) (((Case.get_id c) mod w) * 20) img_h screen;

    if not (List.exists ((=) ((Case.get_id c) + w)) (Case.get_door c))
    then blit_img ((((Case.get_id c) / w) + 1) * 20) (((Case.get_id c) mod w) * 20) img_h screen;

    if not (List.exists ((=) ((Case.get_id c) + 1)) (Case.get_door c))
    then blit_img (((Case.get_id c) / w) * 20) ((((Case.get_id c) mod w) + 1) * 20) img_v screen;
  end

(*
 * Fonction servant a dessiner le labyrinthe
 *)
let draw map screen =
  let w = CaseMap.get_width map in
  let img_h = Sdlloader.load_image "h.png" in
  let img_v = Sdlloader.load_image "v.png" in
  let rec draw_aux map = match map with
    | [] -> ()
    | c::r -> blit_case c screen w img_h img_v; draw_aux r
  in
    begin
      draw_aux (CaseMap.get_case_list map);
      Sdlvideo.flip screen
    end

let draw_soluce l screen w =
  let img = Sdlloader.load_image "c.png" in
  let rec draw_soluce_aux = function
    | [] -> ()
    | id::r -> blit_img ((id / w) * 20) ((id mod w) * 20) img screen; draw_soluce_aux r
  in
  draw_soluce_aux l

let clear screen =
  Sdlvideo.fill_rect screen (Int32.zero)
