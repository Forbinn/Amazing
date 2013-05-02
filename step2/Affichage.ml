open Case

(*
 * init de la SDL
 *)
let init w h =
  begin
    Sdl.init [`VIDEO];
    let screen = Sdlvideo.set_video_mode (w * 20 + 1) (h * 20 + 1) [] in
    Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen Sdlvideo.white);
    Sdlvideo.flip screen;
    screen
  end

let quit () = Sdl.quit ()

(*
 * Fonction qui wait la touche escape ou la fermeture de la fenetre
 *)
let rec run () = match Sdlevent.wait_event () with
  | Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> ()
  | Sdlevent.QUIT -> ()
  | _ -> run ()


let blit_img x y img screen =
  let pos = Sdlvideo.rect y x 0 0 in
  Sdlvideo.blit_surface ~dst_rect:pos ~src:img ~dst:screen ()

let blit_case c screen w img_h img_v =
  begin
    if not (List.exists ((=) ((Case.get_id c) - 1)) (Case.get_door c))
    then blit_img ((((Case.get_id c) - 1) / w) * 20) ((((Case.get_id c) - 1) mod w) * 20) img_v screen;

    if not (List.exists ((=) ((Case.get_id c) - w)) (Case.get_door c))
    then blit_img ((((Case.get_id c) - 1) / w) * 20) ((((Case.get_id c) - 1) mod w) * 20) img_h screen;

    if not (List.exists ((=) ((Case.get_id c) + w)) (Case.get_door c))
    then blit_img (((((Case.get_id c) - 1) / w) + 1) * 20) ((((Case.get_id c) - 1) mod w) * 20) img_h screen;

    if not (List.exists ((=) ((Case.get_id c) + 1)) (Case.get_door c))
    then blit_img ((((Case.get_id c) - 1) / w) * 20) (((((Case.get_id c) - 1) mod w) + 1) * 20) img_v screen;
  end

(*
 * Fonction servant a dessiner le labyrinthe
 *)
let draw map w screen =
  let img_h = Sdlloader.load_image "h.png" in
  let img_v = Sdlloader.load_image "v.png" in
  let rec draw_aux map = match map with
    | [] -> ()
    | c::r -> blit_case c screen w img_h img_v; draw_aux r
        (*begin
                if (Case.get_id c) mod w = 1 then
                  if (List.exists ((=) ((Case.get_id c) - 1)) (Case.get_door c))
                  then print_char ' ' else print_char '|';

                if (List.exists ((=) ((Case.get_id c) + w)) (Case.get_door c))
                then print_char ' ' else print_char '_';

                if (List.exists ((=) ((Case.get_id c) + 1)) (Case.get_door c))
                then print_char ' ' else print_char '|';

                if (i mod w) = 0 then print_endline "";
                draw_aux (i + 1) r
              end
                *)
  in
    begin
      draw_aux map;
      Sdlvideo.flip screen
    end
