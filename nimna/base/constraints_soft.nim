#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaScInit*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_sc_init",
    importRna.}

proc vrnaScSetBp*(vc: ptr VrnaFoldCompoundT; constraints: ptr ptr Flt_Or_Dbl;
                 options: cuint) {.cdecl, importc: "vrna_sc_set_bp", importRna.}

proc vrnaScAddBp*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; energy: Flt_Or_Dbl;
                 options: cuint) {.cdecl, importc: "vrna_sc_add_bp", importRna.}

proc vrnaScSetUp*(vc: ptr VrnaFoldCompoundT; constraints: ptr Flt_Or_Dbl;
                 options: cuint) {.cdecl, importc: "vrna_sc_set_up", importRna.}

proc vrnaScAddUp*(vc: ptr VrnaFoldCompoundT; i: cint; energy: Flt_Or_Dbl; options: cuint) {.
    cdecl, importc: "vrna_sc_add_up", importRna.}

proc vrnaScRemove*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_sc_remove",
    importRna.}

proc vrnaScFree*(sc: ptr VrnaScT) {.cdecl, importc: "vrna_sc_free", importRna.}

proc vrnaScAddData*(vc: ptr VrnaFoldCompoundT; data: pointer;
                   freeData: ptr VrnaCallbackFreeAuxdata) {.cdecl,
    importc: "vrna_sc_add_data", importRna.}

proc vrnaScAddF*(vc: ptr VrnaFoldCompoundT; f: ptr VrnaCallbackScEnergy) {.cdecl,
    importc: "vrna_sc_add_f", importRna.}

proc vrnaScAddBt*(vc: ptr VrnaFoldCompoundT; f: ptr VrnaCallbackScBacktrack) {.cdecl,
    importc: "vrna_sc_add_bt", importRna.}

proc vrnaScAddExpF*(vc: ptr VrnaFoldCompoundT; expF: ptr VrnaCallbackScExpEnergy) {.
    cdecl, importc: "vrna_sc_add_exp_f", importRna.}
