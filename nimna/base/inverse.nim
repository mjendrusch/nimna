#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  symbolset* {.importc: "symbolset", importRna.}: cstring
  finalCost* {.importc: "final_cost", importRna.}: cfloat
  giveUp* {.importc: "give_up", importRna.}: cint
  invVerbose* {.importc: "inv_verbose", importRna.}: cint

proc inverseFold*(start: cstring; target: cstring): cfloat {.cdecl,
    importc: "inverse_fold", importRna.}

proc inversePfFold*(start: cstring; target: cstring): cfloat {.cdecl,
    importc: "inverse_pf_fold", importRna.}
