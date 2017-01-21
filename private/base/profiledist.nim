#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc profileEditDistance*(t1: ptr cfloat; t2: ptr cfloat): cfloat {.cdecl,
    importc: "profile_edit_distance", dynlib: rnaLib.}

proc makeBpProfileBppm*(bppm: ptr Flt_Or_Dbl; length: cint): ptr cfloat {.cdecl,
    importc: "Make_bp_profile_bppm", dynlib: rnaLib.}

proc printBppm*(t: ptr cfloat) {.cdecl, importc: "print_bppm", dynlib: rnaLib.}

proc freeProfile*(t: ptr cfloat) {.cdecl, importc: "free_profile", dynlib: rnaLib.}
