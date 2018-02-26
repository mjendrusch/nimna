#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  STRUC* = 2000

proc b2HIT*(structure: cstring): cstring {.cdecl, importc: "b2HIT", importRna.}

proc b2C*(structure: cstring): cstring {.cdecl, importc: "b2C", importRna.}

proc b2Shapiro*(structure: cstring): cstring {.cdecl, importc: "b2Shapiro",
    importRna.}

proc addRoot*(structure: cstring): cstring {.cdecl, importc: "add_root", importRna.}

proc expandShapiro*(coarse: cstring): cstring {.cdecl, importc: "expand_Shapiro",
    importRna.}

proc expandFull*(structure: cstring): cstring {.cdecl, importc: "expand_Full",
    importRna.}

proc unexpandFull*(ffull: cstring): cstring {.cdecl, importc: "unexpand_Full",
    importRna.}

proc unweight*(wcoarse: cstring): cstring {.cdecl, importc: "unweight", importRna.}

proc unexpandAlignedF*(align: array[2, cstring]) {.cdecl,
    importc: "unexpand_aligned_F", importRna.}

proc parseStructure*(structure: cstring) {.cdecl, importc: "parse_structure",
                                        importRna.}

var loopSize* {.importc: "loop_size", importRna.}: array[Struc, cint]


var helixSize* {.importc: "helix_size", importRna.}: array[Struc, cint]


var loopDegree* {.importc: "loop_degree", importRna.}: array[Struc, cint]


var loops* {.importc: "loops", importRna.}: cint


var unpaired* {.importc: "unpaired", importRna.}: cint


var pairs* {.importc: "pairs", importRna.}: cint
