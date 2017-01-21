#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  RNA_UP_MODE_1* = 1
  RNA_UP_MODE_2* = 2
  RNA_UP_MODE_3* = 4

proc pfUnstru*(sequence: cstring; maxW: cint): ptr PuContrib {.cdecl,
    importc: "pf_unstru", dynlib: rnaLib.}

proc pfInteract*(s1: cstring; s2: cstring; pC: ptr PuContrib; pC2: ptr PuContrib;
                maxW: cint; cstruc: cstring; incr3: cint; incr5: cint): ptr interact {.
    cdecl, importc: "pf_interact", dynlib: rnaLib.}

proc freeInteract*(pin: ptr interact) {.cdecl, importc: "free_interact", dynlib: rnaLib.}

proc upPlot*(pC: ptr PuContrib; pCSh: ptr PuContrib; pint: ptr interact; ofile: cstring;
            unpairedValues: ptr ptr cint; selectContrib: cstring; head: cstring;
            mode: cuint): cint {.cdecl, importc: "Up_plot", dynlib: rnaLib.}

proc getPuContribStruct*(n: cuint; w: cuint): ptr PuContrib {.cdecl,
    importc: "get_pu_contrib_struct", dynlib: rnaLib.}

proc freePuContribStruct*(pu: ptr PuContrib) {.cdecl,
    importc: "free_pu_contrib_struct", dynlib: rnaLib.}
proc freePuContrib*(pu: ptr PuContrib) {.cdecl, importc: "free_pu_contrib",
                                     dynlib: rnaLib.}
