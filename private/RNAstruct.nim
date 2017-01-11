#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



const
  STRUC* = 2000


proc b2HIT*(structure: cstring): cstring {.cdecl, importc: "b2HIT", dynlib: rnaLib.}

proc b2C*(structure: cstring): cstring {.cdecl, importc: "b2C", dynlib: rnaLib.}

proc b2Shapiro*(structure: cstring): cstring {.cdecl, importc: "b2Shapiro",
    dynlib: rnaLib.}

proc addRoot*(structure: cstring): cstring {.cdecl, importc: "add_root", dynlib: rnaLib.}

proc expandShapiro*(coarse: cstring): cstring {.cdecl, importc: "expand_Shapiro",
    dynlib: rnaLib.}

proc expandFull*(structure: cstring): cstring {.cdecl, importc: "expand_Full",
    dynlib: rnaLib.}

proc unexpandFull*(ffull: cstring): cstring {.cdecl, importc: "unexpand_Full",
    dynlib: rnaLib.}

proc unweight*(wcoarse: cstring): cstring {.cdecl, importc: "unweight", dynlib: rnaLib.}

proc unexpandAlignedF*(align: array[2, cstring]) {.cdecl,
    importc: "unexpand_aligned_F", dynlib: rnaLib.}

proc parseStructure*(structure: cstring) {.cdecl, importc: "parse_structure",
                                        dynlib: rnaLib.}

var loopSize* {.importc: "loop_size", dynlib: rnaLib.}: array[struc, cint]


var helixSize* {.importc: "helix_size", dynlib: rnaLib.}: array[struc, cint]


var loopDegree* {.importc: "loop_degree", dynlib: rnaLib.}: array[struc, cint]


var loops* {.importc: "loops", dynlib: rnaLib.}: cint


var unpaired* {.importc: "unpaired", dynlib: rnaLib.}: cint


var pairs* {.importc: "pairs", dynlib: rnaLib.}: cint

