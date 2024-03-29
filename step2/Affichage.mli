open Case
open CaseMap

val init : int -> int -> Sdlvideo.surface
val quit : unit -> unit
val run : unit -> unit
val blit_img : int -> int -> Sdlvideo.surface -> Sdlvideo.surface -> unit
val draw : CaseMap.map -> Sdlvideo.surface -> unit
