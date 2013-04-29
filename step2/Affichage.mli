open Case

val init : int -> int -> Sdlvideo.surface
val quit : unit -> unit
val run : unit -> unit
val blit_img : int -> int -> Sdlvideo.surface -> Sdlvideo.surface -> unit
val draw : case list -> int -> Sdlvideo.surface -> unit
