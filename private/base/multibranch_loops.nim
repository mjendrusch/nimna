#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc e_mbLoopStack*(i: cint; j: cint; vc: ptr VrnaFoldCompoundT): cint {.cdecl,
    importc: "E_mb_loop_stack", dynlib: rnaLib.}
proc vrnaBT_mbLoop*(vc: ptr VrnaFoldCompoundT; i: ptr cint; j: ptr cint; k: ptr cint;
                   en: cint; component1: ptr cint; component2: ptr cint): cint {.cdecl,
    importc: "vrna_BT_mb_loop", dynlib: rnaLib.}
proc vrnaE_mbLoopFast*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; dmli1: ptr cint;
                      dmli2: ptr cint): cint {.cdecl, importc: "vrna_E_mb_loop_fast",
    dynlib: rnaLib.}
proc e_mlRightmostStem*(i: cint; j: cint; vc: ptr VrnaFoldCompoundT): cint {.cdecl,
    importc: "E_ml_rightmost_stem", dynlib: rnaLib.}
proc vrnaE_mlStemsFast*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; fmi: ptr cint;
                       dmli: ptr cint): cint {.cdecl,
    importc: "vrna_E_ml_stems_fast", dynlib: rnaLib.}
proc vrnaExpE_mbLoopFast*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint;
                         qqm1: ptr Flt_Or_Dbl): Flt_Or_Dbl {.cdecl,
    importc: "vrna_exp_E_mb_loop_fast", dynlib: rnaLib.}

proc vrnaBT_mbLoopFake*(vc: ptr VrnaFoldCompoundT; u: ptr cint; i: ptr cint; j: ptr cint;
                       bpStack: ptr VrnaBpStackT; stackCount: ptr cint): cint {.cdecl,
    importc: "vrna_BT_mb_loop_fake", dynlib: rnaLib.}
proc vrnaBT_mbLoopSplit*(vc: ptr VrnaFoldCompoundT; i: ptr cint; j: ptr cint; k: ptr cint;
                        l: ptr cint; component1: ptr cint; component2: ptr cint;
                        bpStack: ptr VrnaBpStackT; stackCount: ptr cint): cint {.cdecl,
    importc: "vrna_BT_mb_loop_split", dynlib: rnaLib.}
