#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  MaxDos* = 1000

var
  printEnergy* {.importc: "print_energy", importRna.}: cdouble
  suboptSorted* {.importc: "subopt_sorted", importRna.}: cint
  densityOfStates* {.importc: "density_of_states", importRna.}: array[
    MaxDos + 1, cint]

proc vrnaSubopt*(vc: ptr VrnaFoldCompoundT; delta: cint; sorted: cint; fp: File): ptr VrnaSuboptSolutionT {.
    cdecl, importc: "vrna_subopt", importRna.}

proc vrnaSuboptCb*(vc: ptr VrnaFoldCompoundT; delta: cint; cb: ptr VrnaSuboptCallback;
                  data: pointer) {.cdecl, importc: "vrna_subopt_cb", importRna.}

proc vrnaSuboptZuker*(vc: ptr VrnaFoldCompoundT): ptr VrnaSuboptSolutionT {.cdecl,
    importc: "vrna_subopt_zuker", importRna.}
