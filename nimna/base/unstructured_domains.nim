#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_UNSTRUCTURED_DOMAIN_EXT_LOOP* = 1
  VRNA_UNSTRUCTURED_DOMAIN_HP_LOOP* = 2
  VRNA_UNSTRUCTURED_DOMAIN_INT_LOOP* = 4
  VRNA_UNSTRUCTURED_DOMAIN_MB_LOOP* = 8
  VRNA_UNSTRUCTURED_DOMAIN_MOTIF* = 16
  VRNA_UNSTRUCTURED_DOMAIN_ALL_LOOPS* = (Vrna_Unstructured_Domain_Ext_Loop or
      Vrna_Unstructured_Domain_Hp_Loop or Vrna_Unstructured_Domain_Int_Loop or
      Vrna_Unstructured_Domain_Mb_Loop)

proc vrnaUdAddMotif*(vc: ptr VrnaFoldCompoundT; motif: cstring; motifEn: cdouble;
                    loopType: cuint) {.cdecl, importc: "vrna_ud_add_motif",
                                     importRna.}
proc vrnaUdGetMotifSizeAt*(vc: ptr VrnaFoldCompoundT; i: cint; loopType: cuint): ptr cint {.
    cdecl, importc: "vrna_ud_get_motif_size_at", importRna.}
proc vrnaUdGetMotifsAt*(vc: ptr VrnaFoldCompoundT; i: cint; loopType: cuint): ptr cint {.
    cdecl, importc: "vrna_ud_get_motifs_at", importRna.}
proc vrnaUdDetectMotifs*(vc: ptr VrnaFoldCompoundT; structure: cstring): ptr VrnaUdMotifT {.
    cdecl, importc: "vrna_ud_detect_motifs", importRna.}
proc vrnaUdRemove*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_ud_remove",
    importRna.}
proc vrnaUdSetData*(vc: ptr VrnaFoldCompoundT; data: pointer;
                   freeCb: ptr VrnaCallbackFreeAuxdata) {.cdecl,
    importc: "vrna_ud_set_data", importRna.}
proc vrnaUdSetProdRuleCb*(vc: ptr VrnaFoldCompoundT;
                         preCb: ptr VrnaCallbackUdProduction;
                         eCb: ptr VrnaCallbackUdEnergy) {.cdecl,
    importc: "vrna_ud_set_prod_rule_cb", importRna.}
proc vrnaUdSetExpProdRuleCb*(vc: ptr VrnaFoldCompoundT;
                            preCb: ptr VrnaCallbackUdExpProduction;
                            expECb: ptr VrnaCallbackUdExpEnergy) {.cdecl,
    importc: "vrna_ud_set_exp_prod_rule_cb", importRna.}
proc vrnaUdSetProbCb*(vc: ptr VrnaFoldCompoundT; setter: ptr VrnaCallbackUdProbsAdd;
                     getter: ptr VrnaCallbackUdProbsGet) {.cdecl,
    importc: "vrna_ud_set_prob_cb", importRna.}
