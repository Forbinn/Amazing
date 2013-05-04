open Case
open CaseMap

val init : int -> int -> Sdlvideo.surface
val quit : unit -> unit
val run : ((int * int) list -> unit) -> unit
val blit_img : int -> int -> Sdlvideo.surface -> Sdlvideo.surface -> unit
val draw : CaseMap.map -> Sdlvideo.surface -> unit
val draw_soluce : int list -> Sdlvideo.surface -> int -> unit
val clear : Sdlvideo.surface -> unit
