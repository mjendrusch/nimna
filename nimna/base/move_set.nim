#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

type
  StructEn* = object
    energy*: cint
    structure*: ptr cshort

proc printStren*(`out`: ptr File; str: ptr StructEn) {.cdecl, importc: "print_stren",
    dynlib: rnaLib.}
proc printStr*(`out`: ptr File; str: ptr cshort) {.cdecl, importc: "print_str",
    dynlib: rnaLib.}

proc copyArr*(dest: ptr cshort; src: ptr cshort) {.cdecl, importc: "copy_arr",
    dynlib: rnaLib.}

proc allocopy*(src: ptr cshort): ptr cshort {.cdecl, importc: "allocopy", dynlib: rnaLib.}

type
  Move_Type* {.size: sizeof(cint).} = enum
    GRADIENT, FIRST, ADAPTIVE



proc moveGradient*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
                  verbosityLevel: cint; shifts: cint; noLP: cint): cint {.cdecl,
    importc: "move_gradient", dynlib: rnaLib.}
proc moveFirst*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
               verbosityLevel: cint; shifts: cint; noLP: cint): cint {.cdecl,
    importc: "move_first", dynlib: rnaLib.}
proc moveAdaptive*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
                  verbosityLevel: cint): cint {.cdecl, importc: "move_adaptive",
    dynlib: rnaLib.}

proc moveStandard*(seq: cstring; struc: cstring; `type`: Move_Type;
                  verbosityLevel: cint; shifts: cint; noLP: cint): cint {.cdecl,
    importc: "move_standard", dynlib: rnaLib.}

proc browseNeighsPt*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
                    verbosityLevel: cint; shifts: cint; noLP: cint; funct: proc (
    a2: ptr StructEn; a3: ptr StructEn): cint {.cdecl.}): cint {.cdecl,
    importc: "browse_neighs_pt", dynlib: rnaLib.}
proc browseNeighs*(seq: cstring; struc: cstring; verbosityLevel: cint; shifts: cint;
                  noLP: cint; funct: proc (a2: ptr StructEn; a3: ptr StructEn): cint {.
    cdecl.}): cint {.cdecl, importc: "browse_neighs", dynlib: rnaLib.}
