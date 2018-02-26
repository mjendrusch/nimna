#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaE_intLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): cint {.cdecl,
    importc: "vrna_E_int_loop", importRna.}
proc vrnaEvalIntLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; k: cint; l: cint): cint {.
    cdecl, importc: "vrna_eval_int_loop", importRna.}
proc vrnaExpE_intLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): Flt_Or_Dbl {.cdecl,
    importc: "vrna_exp_E_int_loop", importRna.}
proc vrnaExpE_interiorLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; k: cint; l: cint): Flt_Or_Dbl {.
    cdecl, importc: "vrna_exp_E_interior_loop", importRna.}
proc vrnaE_extIntLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; ip: ptr cint;
                      iq: ptr cint): cint {.cdecl, importc: "vrna_E_ext_int_loop",
                                        importRna.}
proc vrnaE_stack*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): cint {.cdecl,
    importc: "vrna_E_stack", importRna.}

proc vrnaBT_stack*(vc: ptr VrnaFoldCompoundT; i: ptr cint; j: ptr cint; en: ptr cint;
                  bpStack: ptr VrnaBpStackT; stackCount: ptr cint): cint {.cdecl,
    importc: "vrna_BT_stack", importRna.}

proc vrnaBT_intLoop*(vc: ptr VrnaFoldCompoundT; i: ptr cint; j: ptr cint; en: cint;
                    bpStack: ptr VrnaBpStackT; stackCount: ptr cint): cint {.cdecl,
    importc: "vrna_BT_int_loop", importRna.}
