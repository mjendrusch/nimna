#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.


#const rnaLib = "./RNA.so"

const
  VRNA_BACKWARD_COMPAT* = true

const
  VRNA_MODEL_DEFAULT_TEMPERATURE* = 37.0
  VRNA_MODEL_DEFAULT_PF_SCALE* = - 1
  VRNA_MODEL_DEFAULT_BETA_SCALE* = 1.0
  VRNA_MODEL_DEFAULT_DANGLES* = 2
  VRNA_MODEL_DEFAULT_SPECIAL_HP* = 1
  VRNA_MODEL_DEFAULT_NO_LP* = 0
  VRNA_MODEL_DEFAULT_NO_GU* = 0
  VRNA_MODEL_DEFAULT_NO_GU_CLOSURE* = 0
  VRNA_MODEL_DEFAULT_CIRC* = 0
  VRNA_MODEL_DEFAULT_GQUAD* = 0
  VRNA_MODEL_DEFAULT_CANONICAL_BP* = 0
  VRNA_MODEL_DEFAULT_UNIQ_ML* = 0
  VRNA_MODEL_DEFAULT_ENERGY_SET* = 0
  VRNA_MODEL_DEFAULT_BACKTRACK* = 1
  VRNA_MODEL_DEFAULT_BACKTRACK_TYPE* = 'F'
  VRNA_MODEL_DEFAULT_COMPUTE_BPP* = 1
  VRNA_MODEL_DEFAULT_MAX_BP_SPAN* = - 1
  VRNA_MODEL_DEFAULT_WINDOW_SIZE* = - 1
  VRNA_MODEL_DEFAULT_LOG_ML* = 0
  VRNA_MODEL_DEFAULT_ALI_OLD_EN* = 0
  VRNA_MODEL_DEFAULT_ALI_RIBO* = 0
  VRNA_MODEL_DEFAULT_ALI_CV_FACT* = 1.0
  VRNA_MODEL_DEFAULT_ALI_NC_FACT* = 1.0

proc vrnaMdSetDefault*(md: ptr VrnaMdT) {.cdecl, importc: "vrna_md_set_default",
                                      dynlib: rnaLib.}

proc vrnaMdUpdate*(md: ptr VrnaMdT) {.cdecl, importc: "vrna_md_update", dynlib: rnaLib.}

proc vrnaMdCopy*(mdTo: ptr VrnaMdT; mdFrom: ptr VrnaMdT): ptr VrnaMdT {.cdecl,
    importc: "vrna_md_copy", dynlib: rnaLib.}

proc vrnaMdOptionString*(md: ptr VrnaMdT): cstring {.cdecl,
    importc: "vrna_md_option_string", dynlib: rnaLib.}
proc vrnaMdSetNonstandards*(md: ptr VrnaMdT; nsBases: cstring) {.cdecl,
    importc: "vrna_md_set_nonstandards", dynlib: rnaLib.}

proc vrnaMdDefaultsReset*(mdP: ptr VrnaMdT) {.cdecl,
    importc: "vrna_md_defaults_reset", dynlib: rnaLib.}

proc vrnaMdDefaultsTemperature*(t: cdouble) {.cdecl,
    importc: "vrna_md_defaults_temperature", dynlib: rnaLib.}

proc vrnaMdDefaultsTemperatureGet*(): cdouble {.cdecl,
    importc: "vrna_md_defaults_temperature_get", dynlib: rnaLib.}

proc vrnaMdDefaultsBetaScale*(b: cdouble) {.cdecl,
    importc: "vrna_md_defaults_betaScale", dynlib: rnaLib.}

proc vrnaMdDefaultsBetaScaleGet*(): cdouble {.cdecl,
    importc: "vrna_md_defaults_betaScale_get", dynlib: rnaLib.}

proc vrnaMdDefaultsDangles*(d: cint) {.cdecl, importc: "vrna_md_defaults_dangles",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsDanglesGet*(): cint {.cdecl,
                                      importc: "vrna_md_defaults_dangles_get",
                                      dynlib: rnaLib.}

proc vrnaMdDefaultsSpecialHp*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_special_hp", dynlib: rnaLib.}

proc vrnaMdDefaultsSpecialHpGet*(): cint {.cdecl, importc: "vrna_md_defaults_special_hp_get",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsNoLP*(flag: cint) {.cdecl, importc: "vrna_md_defaults_noLP",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsNoLP_get*(): cint {.cdecl, importc: "vrna_md_defaults_noLP_get",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsNoGU*(flag: cint) {.cdecl, importc: "vrna_md_defaults_noGU",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsNoGU_get*(): cint {.cdecl, importc: "vrna_md_defaults_noGU_get",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsNoGUclosure*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_noGUclosure", dynlib: rnaLib.}

proc vrnaMdDefaultsNoGUclosureGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_noGUclosure_get", dynlib: rnaLib.}

proc vrnaMdDefaultsLogML*(flag: cint) {.cdecl, importc: "vrna_md_defaults_logML",
                                     dynlib: rnaLib.}

proc vrnaMdDefaultsLogML_get*(): cint {.cdecl,
                                     importc: "vrna_md_defaults_logML_get",
                                     dynlib: rnaLib.}

proc vrnaMdDefaultsCirc*(flag: cint) {.cdecl, importc: "vrna_md_defaults_circ",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsCircGet*(): cint {.cdecl, importc: "vrna_md_defaults_circ_get",
                                   dynlib: rnaLib.}

proc vrnaMdDefaultsGquad*(flag: cint) {.cdecl, importc: "vrna_md_defaults_gquad",
                                     dynlib: rnaLib.}

proc vrnaMdDefaultsGquadGet*(): cint {.cdecl, importc: "vrna_md_defaults_gquad_get",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsUniqML*(flag: cint) {.cdecl, importc: "vrna_md_defaults_uniq_ML",
                                      dynlib: rnaLib.}

proc vrnaMdDefaultsUniqML_get*(): cint {.cdecl,
                                      importc: "vrna_md_defaults_uniq_ML_get",
                                      dynlib: rnaLib.}

proc vrnaMdDefaultsEnergySet*(e: cint) {.cdecl,
                                      importc: "vrna_md_defaults_energy_set",
                                      dynlib: rnaLib.}

proc vrnaMdDefaultsEnergySetGet*(): cint {.cdecl, importc: "vrna_md_defaults_energy_set_get",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsBacktrack*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_backtrack", dynlib: rnaLib.}

proc vrnaMdDefaultsBacktrackGet*(): cint {.cdecl, importc: "vrna_md_defaults_backtrack_get",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsBacktrackType*(t: char) {.cdecl,
    importc: "vrna_md_defaults_backtrack_type", dynlib: rnaLib.}

proc vrnaMdDefaultsBacktrackTypeGet*(): char {.cdecl,
    importc: "vrna_md_defaults_backtrack_type_get", dynlib: rnaLib.}

proc vrnaMdDefaultsComputeBpp*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_compute_bpp", dynlib: rnaLib.}

proc vrnaMdDefaultsComputeBppGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_compute_bpp_get", dynlib: rnaLib.}

proc vrnaMdDefaultsMaxBpSpan*(span: cint) {.cdecl,
    importc: "vrna_md_defaults_max_bp_span", dynlib: rnaLib.}

proc vrnaMdDefaultsMaxBpSpanGet*(): cint {.cdecl, importc: "vrna_md_defaults_max_bp_span_get",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsMinLoopSize*(size: cint) {.cdecl,
    importc: "vrna_md_defaults_min_loop_size", dynlib: rnaLib.}

proc vrnaMdDefaultsMinLoopSizeGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_min_loop_size_get", dynlib: rnaLib.}

proc vrnaMdDefaultsWindowSize*(size: cint) {.cdecl,
    importc: "vrna_md_defaults_window_size", dynlib: rnaLib.}

proc vrnaMdDefaultsWindowSizeGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_window_size_get", dynlib: rnaLib.}

proc vrnaMdDefaultsOldAliEn*(flag: cint) {.cdecl,
                                        importc: "vrna_md_defaults_oldAliEn",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsOldAliEnGet*(): cint {.cdecl, importc: "vrna_md_defaults_oldAliEn_get",
                                       dynlib: rnaLib.}

proc vrnaMdDefaultsRibo*(flag: cint) {.cdecl, importc: "vrna_md_defaults_ribo",
                                    dynlib: rnaLib.}

proc vrnaMdDefaultsRiboGet*(): cint {.cdecl, importc: "vrna_md_defaults_ribo_get",
                                   dynlib: rnaLib.}

proc vrnaMdDefaultsCvFact*(factor: cdouble) {.cdecl,
    importc: "vrna_md_defaults_cv_fact", dynlib: rnaLib.}

proc vrnaMdDefaultsCvFactGet*(): cdouble {.cdecl, importc: "vrna_md_defaults_cv_fact_get",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsNcFact*(factor: cdouble) {.cdecl,
    importc: "vrna_md_defaults_nc_fact", dynlib: rnaLib.}

proc vrnaMdDefaultsNcFactGet*(): cdouble {.cdecl, importc: "vrna_md_defaults_nc_fact_get",
                                        dynlib: rnaLib.}

proc vrnaMdDefaultsSfact*(factor: cdouble) {.cdecl,
    importc: "vrna_md_defaults_sfact", dynlib: rnaLib.}

proc vrnaMdDefaultsSfactGet*(): cdouble {.cdecl,
                                       importc: "vrna_md_defaults_sfact_get",
                                       dynlib: rnaLib.}
when defined(VRNA_BACKWARD_COMPAT):
  const
    modelDetailsT* = vrnaMdT
  var temperature* {.importc: "temperature", dynlib: rnaLib.}: cdouble
  var pfScale* {.importc: "pf_scale", dynlib: rnaLib.}: cdouble
  var dangles* {.importc: "dangles", dynlib: rnaLib.}: cint
  var tetraLoop* {.importc: "tetra_loop", dynlib: rnaLib.}: cint
  var noLonelyPairs* {.importc: "noLonelyPairs", dynlib: rnaLib.}: cint
  var noGU* {.importc: "noGU", dynlib: rnaLib.}: cint
  var noClosingGU* {.importc: "no_closingGU", dynlib: rnaLib.}: cint
  var circ* {.importc: "circ", dynlib: rnaLib.}: cint
  var gquad* {.importc: "gquad", dynlib: rnaLib.}: cint
  var canonicalBPonly* {.importc: "canonicalBPonly", dynlib: rnaLib.}: cint
  var uniqML* {.importc: "uniq_ML", dynlib: rnaLib.}: cint
  var energySet* {.importc: "energy_set", dynlib: rnaLib.}: cint
  var doBacktrack* {.importc: "do_backtrack", dynlib: rnaLib.}: cint
  var backtrackType* {.importc: "backtrack_type", dynlib: rnaLib.}: char
  var nonstandards* {.importc: "nonstandards", dynlib: rnaLib.}: cstring
  var maxBpSpan* {.importc: "max_bp_span", dynlib: rnaLib.}: cint
  var oldAliEn* {.importc: "oldAliEn", dynlib: rnaLib.}: cint
  var ribo* {.importc: "ribo", dynlib: rnaLib.}: cint
  var cvFact* {.importc: "cv_fact", dynlib: rnaLib.}: cdouble
  var ncFact* {.importc: "nc_fact", dynlib: rnaLib.}: cdouble
  var logML* {.importc: "logML", dynlib: rnaLib.}: cint
  proc setModelDetails*(md: ptr VrnaMdT) {.cdecl, importc: "set_model_details",
                                       dynlib: rnaLib.}
  proc optionString*(): cstring {.cdecl, importc: "option_string", dynlib: rnaLib.}
