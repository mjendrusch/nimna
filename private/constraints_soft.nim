#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



type
  VrnaScT* = vrnaScS


type
  VrnaCallbackScEnergy* = proc (i: cint; j: cint; k: cint; l: cint; d: char; data: pointer): cint {.
      cdecl.}


type
  VrnaCallbackScExpEnergy* = proc (i: cint; j: cint; k: cint; l: cint; d: char; data: pointer): Flt_Or_Dbl {.
      cdecl.}


type
  VrnaCallbackScBacktrack* = proc (i: cint; j: cint; k: cint; l: cint; d: char; data: pointer): ptr VrnaBasepairT {.
      cdecl.}


type
  VrnaScS* = object
    energyUp*: ptr ptr cint
    energyBp*: ptr cint
    expEnergyUp*: ptr ptr Flt_Or_Dbl
    expEnergyBp*: ptr Flt_Or_Dbl
    energyStack*: ptr cint
    expEnergyStack*: ptr Flt_Or_Dbl
    f*: ptr VrnaCallbackScEnergy
    bt*: ptr VrnaCallbackScBacktrack
    expF*: ptr VrnaCallbackScExpEnergy
    data*: pointer
    freeData*: ptr VrnaCallbackFreeAuxdata



proc vrnaScInit*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_sc_init",
    dynlib: rnaLib.}

proc vrnaScSetBp*(vc: ptr VrnaFoldCompoundT; constraints: ptr ptr Flt_Or_Dbl;
                 options: cuint) {.cdecl, importc: "vrna_sc_set_bp", dynlib: rnaLib.}

proc vrnaScAddBp*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; energy: Flt_Or_Dbl;
                 options: cuint) {.cdecl, importc: "vrna_sc_add_bp", dynlib: rnaLib.}

proc vrnaScSetUp*(vc: ptr VrnaFoldCompoundT; constraints: ptr Flt_Or_Dbl;
                 options: cuint) {.cdecl, importc: "vrna_sc_set_up", dynlib: rnaLib.}

proc vrnaScAddUp*(vc: ptr VrnaFoldCompoundT; i: cint; energy: Flt_Or_Dbl; options: cuint) {.
    cdecl, importc: "vrna_sc_add_up", dynlib: rnaLib.}

proc vrnaScRemove*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_sc_remove",
    dynlib: rnaLib.}

proc vrnaScFree*(sc: ptr VrnaScT) {.cdecl, importc: "vrna_sc_free", dynlib: rnaLib.}

proc vrnaScAddData*(vc: ptr VrnaFoldCompoundT; data: pointer;
                   freeData: ptr VrnaCallbackFreeAuxdata) {.cdecl,
    importc: "vrna_sc_add_data", dynlib: rnaLib.}

proc vrnaScAddF*(vc: ptr VrnaFoldCompoundT; f: ptr VrnaCallbackScEnergy) {.cdecl,
    importc: "vrna_sc_add_f", dynlib: rnaLib.}

proc vrnaScAddBt*(vc: ptr VrnaFoldCompoundT; f: ptr VrnaCallbackScBacktrack) {.cdecl,
    importc: "vrna_sc_add_bt", dynlib: rnaLib.}

proc vrnaScAddExpF*(vc: ptr VrnaFoldCompoundT; expF: ptr VrnaCallbackScExpEnergy) {.
    cdecl, importc: "vrna_sc_add_exp_f", dynlib: rnaLib.}