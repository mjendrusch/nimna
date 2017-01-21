#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc e_ExtLoop*(`type`: cint; si1: cint; sj1: cint; p: ptr VrnaParamT): cint {.cdecl,
    importc: "E_ExtLoop", dynlib: rnaLib.}

proc expE_ExtLoop*(`type`: cint; si1: cint; sj1: cint; p: ptr VrnaExpParamT): Flt_Or_Dbl {.
    cdecl, importc: "exp_E_ExtLoop", dynlib: rnaLib.}

proc e_Stem*(`type`: cint; si1: cint; sj1: cint; extLoop: cint; p: ptr VrnaParamT): cint {.
    cdecl, importc: "E_Stem", dynlib: rnaLib.}

proc expE_Stem*(`type`: cint; si1: cint; sj1: cint; extLoop: cint; p: ptr VrnaExpParamT): Flt_Or_Dbl {.
    cdecl, importc: "exp_E_Stem", dynlib: rnaLib.}
proc e_extLoop*(i: cint; j: cint; vc: ptr VrnaFoldCompoundT): cint {.cdecl,
    importc: "E_ext_loop", dynlib: rnaLib.}
proc e_extLoop5*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "E_ext_loop_5",
    dynlib: rnaLib.}
proc vrnaBT_extLoopF5*(vc: ptr VrnaFoldCompoundT; k: ptr cint; i: ptr cint; j: ptr cint;
                      bpStack: ptr VrnaBpStackT; stackCount: ptr cint): cint {.cdecl,
    importc: "vrna_BT_ext_loop_f5", dynlib: rnaLib.}
