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
    importRna.}
proc printStr*(`out`: ptr File; str: ptr cshort) {.cdecl, importc: "print_str",
    importRna.}

proc copyArr*(dest: ptr cshort; src: ptr cshort) {.cdecl, importc: "copy_arr",
    importRna.}

proc allocopy*(src: ptr cshort): ptr cshort {.cdecl, importc: "allocopy", importRna.}

type
  Move_Type* {.size: sizeof(cint).} = enum
    GRADIENT, FIRST, ADAPTIVE

proc moveGradient*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
                  verbosityLevel: cint; shifts: cint; noLP: cint): cint {.cdecl,
    importc: "move_gradient", importRna.}
proc moveFirst*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
               verbosityLevel: cint; shifts: cint; noLP: cint): cint {.cdecl,
    importc: "move_first", importRna.}
proc moveAdaptive*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
                  verbosityLevel: cint): cint {.cdecl, importc: "move_adaptive",
    importRna.}

proc moveStandard*(seq: cstring; struc: cstring; `type`: Move_Type;
                  verbosityLevel: cint; shifts: cint; noLP: cint): cint {.cdecl,
    importc: "move_standard", importRna.}

proc browseNeighsPt*(seq: cstring; ptable: ptr cshort; s: ptr cshort; s1: ptr cshort;
                    verbosityLevel: cint; shifts: cint; noLP: cint; funct: proc (
    a2: ptr StructEn; a3: ptr StructEn): cint {.cdecl.}): cint {.cdecl,
    importc: "browse_neighs_pt", importRna.}
proc browseNeighs*(seq: cstring; struc: cstring; verbosityLevel: cint; shifts: cint;
                  noLP: cint; funct: proc (a2: ptr StructEn; a3: ptr StructEn): cint {.
    cdecl.}): cint {.cdecl, importc: "browse_neighs", importRna.}
