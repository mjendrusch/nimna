#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  MaxDos* = 1000

proc vrnaSubopt*(vc: ptr VrnaFoldCompoundT; delta: cint; sorted: cint; fp: File): ptr VrnaSuboptSolutionT {.
    cdecl, importc: "vrna_subopt", dynlib: rnaLib.}

proc vrnaSuboptCb*(vc: ptr VrnaFoldCompoundT; delta: cint; cb: ptr VrnaSuboptCallback;
                  data: pointer) {.cdecl, importc: "vrna_subopt_cb", dynlib: rnaLib.}

proc vrnaSuboptZuker*(vc: ptr VrnaFoldCompoundT): ptr VrnaSuboptSolutionT {.cdecl,
    importc: "vrna_subopt_zuker", dynlib: rnaLib.}

var printEnergy* {.importc: "print_energy", dynlib: rnaLib.}: cdouble


var suboptSorted* {.importc: "subopt_sorted", dynlib: rnaLib.}: cint


var densityOfStates* {.importc: "density_of_states", dynlib: rnaLib.}: array[
    MaxDos + 1, cint]
