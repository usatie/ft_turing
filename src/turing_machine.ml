open Yojson.Basic.Util
open Types

let create_machine tmd input =
  { description = tmd; tape = input; head_pos = 0; state = tmd.initial }
