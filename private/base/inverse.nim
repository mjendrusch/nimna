#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  symbolset* {.importc: "symbolset", dynlib: rnaLib.}: cstring
  finalCost* {.importc: "final_cost", dynlib: rnaLib.}: cfloat
  giveUp* {.importc: "give_up", dynlib: rnaLib.}: cint
  invVerbose* {.importc: "inv_verbose", dynlib: rnaLib.}: cint

proc inverseFold*(start: cstring; target: cstring): cfloat {.cdecl,
    importc: "inverse_fold", dynlib: rnaLib.}

proc inversePfFold*(start: cstring; target: cstring): cfloat {.cdecl,
    importc: "inverse_pf_fold", dynlib: rnaLib.}
