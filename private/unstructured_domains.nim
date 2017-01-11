#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



type
  VrnaUdT* = vrnaUnstructuredDomainS
  VrnaUdMotifT* = vrnaUnstructuredDomainMotifS


type
  VrnaCallbackUdEnergy* = proc (vc: ptr VrnaFoldCompoundT; i: cint; j: cint;
                             loopType: cuint; data: pointer): cint {.cdecl.}


type
  VrnaCallbackUdExpEnergy* = proc (vc: ptr VrnaFoldCompoundT; i: cint; j: cint;
                                loopType: cuint; data: pointer): Flt_Or_Dbl {.cdecl.}


type
  VrnaCallbackUdProduction* = proc (vc: ptr VrnaFoldCompoundT; data: pointer) {.cdecl.}


type
  VrnaCallbackUdExpProduction* = proc (vc: ptr VrnaFoldCompoundT; data: pointer) {.cdecl.}


type
  VrnaCallbackUdProbsAdd* = proc (vc: ptr VrnaFoldCompoundT; i: cint; j: cint;
                               loopType: cuint; expEnergy: Flt_Or_Dbl; data: pointer) {.
      cdecl.}


type
  VrnaCallbackUdProbsGet* = proc (vc: ptr VrnaFoldCompoundT; i: cint; j: cint;
                               loopType: cuint; motif: cint; data: pointer): Flt_Or_Dbl {.
      cdecl.}


const
  VRNA_UNSTRUCTURED_DOMAIN_EXT_LOOP* = 1


const
  VRNA_UNSTRUCTURED_DOMAIN_HP_LOOP* = 2


const
  VRNA_UNSTRUCTURED_DOMAIN_INT_LOOP* = 4


const
  VRNA_UNSTRUCTURED_DOMAIN_MB_LOOP* = 8


const
  VRNA_UNSTRUCTURED_DOMAIN_MOTIF* = 16


const
  VRNA_UNSTRUCTURED_DOMAIN_ALL_LOOPS* = (vrna_Unstructured_Domain_Ext_Loop or
      vrna_Unstructured_Domain_Hp_Loop or vrna_Unstructured_Domain_Int_Loop or
      vrna_Unstructured_Domain_Mb_Loop)


type
  VrnaUnstructuredDomainS* = object
    uniqMotifCount*: cint
    uniqMotifSize*: ptr cuint
    motifCount*: cint
    motif*: cstringArray
    motifSize*: ptr cuint
    motifEn*: ptr cdouble
    motifType*: ptr cuint
    prodCb*: ptr VrnaCallbackUdProduction
    expProdCb*: ptr VrnaCallbackUdExpProduction
    energyCb*: ptr VrnaCallbackUdEnergy
    expEnergyCb*: ptr VrnaCallbackUdExpEnergy
    data*: pointer
    freeData*: ptr VrnaCallbackFreeAuxdata
    probsAdd*: ptr VrnaCallbackUdProbsAdd
    probsGet*: ptr VrnaCallbackUdProbsGet

  VrnaUnstructuredDomainMotifS* = object
    start*: cint
    number*: cint



proc vrnaUdAddMotif*(vc: ptr VrnaFoldCompoundT; motif: cstring; motifEn: cdouble;
                    loopType: cuint) {.cdecl, importc: "vrna_ud_add_motif",
                                     dynlib: rnaLib.}

proc vrnaUdGetMotifSizeAt*(vc: ptr VrnaFoldCompoundT; i: cint; loopType: cuint): ptr cint {.
    cdecl, importc: "vrna_ud_get_motif_size_at", dynlib: rnaLib.}
proc vrnaUdGetMotifsAt*(vc: ptr VrnaFoldCompoundT; i: cint; loopType: cuint): ptr cint {.
    cdecl, importc: "vrna_ud_get_motifs_at", dynlib: rnaLib.}
proc vrnaUdDetectMotifs*(vc: ptr VrnaFoldCompoundT; structure: cstring): ptr VrnaUdMotifT {.
    cdecl, importc: "vrna_ud_detect_motifs", dynlib: rnaLib.}

proc vrnaUdRemove*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_ud_remove",
    dynlib: rnaLib.}

proc vrnaUdSetData*(vc: ptr VrnaFoldCompoundT; data: pointer;
                   freeCb: ptr VrnaCallbackFreeAuxdata) {.cdecl,
    importc: "vrna_ud_set_data", dynlib: rnaLib.}

proc vrnaUdSetProdRuleCb*(vc: ptr VrnaFoldCompoundT;
                         preCb: ptr VrnaCallbackUdProduction;
                         eCb: ptr VrnaCallbackUdEnergy) {.cdecl,
    importc: "vrna_ud_set_prod_rule_cb", dynlib: rnaLib.}

proc vrnaUdSetExpProdRuleCb*(vc: ptr VrnaFoldCompoundT;
                            preCb: ptr VrnaCallbackUdExpProduction;
                            expECb: ptr VrnaCallbackUdExpEnergy) {.cdecl,
    importc: "vrna_ud_set_exp_prod_rule_cb", dynlib: rnaLib.}
proc vrnaUdSetProbCb*(vc: ptr VrnaFoldCompoundT; setter: ptr VrnaCallbackUdProbsAdd;
                     getter: ptr VrnaCallbackUdProbsGet) {.cdecl,
    importc: "vrna_ud_set_prob_cb", dynlib: rnaLib.}