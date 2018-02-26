#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

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
                                      importRna.}

proc vrnaMdUpdate*(md: ptr VrnaMdT) {.cdecl, importc: "vrna_md_update", importRna.}

proc vrnaMdCopy*(mdTo: ptr VrnaMdT; mdFrom: ptr VrnaMdT): ptr VrnaMdT {.cdecl,
    importc: "vrna_md_copy", importRna.}

proc vrnaMdOptionString*(md: ptr VrnaMdT): cstring {.cdecl,
    importc: "vrna_md_option_string", importRna.}
proc vrnaMdSetNonstandards*(md: ptr VrnaMdT; nsBases: cstring) {.cdecl,
    importc: "vrna_md_set_nonstandards", importRna.}

proc vrnaMdDefaultsReset*(mdP: ptr VrnaMdT) {.cdecl,
    importc: "vrna_md_defaults_reset", importRna.}

proc vrnaMdDefaultsTemperature*(t: cdouble) {.cdecl,
    importc: "vrna_md_defaults_temperature", importRna.}

proc vrnaMdDefaultsTemperatureGet*(): cdouble {.cdecl,
    importc: "vrna_md_defaults_temperature_get", importRna.}

proc vrnaMdDefaultsBetaScale*(b: cdouble) {.cdecl,
    importc: "vrna_md_defaults_betaScale", importRna.}

proc vrnaMdDefaultsBetaScaleGet*(): cdouble {.cdecl,
    importc: "vrna_md_defaults_betaScale_get", importRna.}

proc vrnaMdDefaultsDangles*(d: cint) {.cdecl, importc: "vrna_md_defaults_dangles",
                                    importRna.}

proc vrnaMdDefaultsDanglesGet*(): cint {.cdecl,
                                      importc: "vrna_md_defaults_dangles_get",
                                      importRna.}

proc vrnaMdDefaultsSpecialHp*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_special_hp", importRna.}

proc vrnaMdDefaultsSpecialHpGet*(): cint {.cdecl, importc: "vrna_md_defaults_special_hp_get",
                                        importRna.}

proc vrnaMdDefaultsNoLP*(flag: cint) {.cdecl, importc: "vrna_md_defaults_noLP",
                                    importRna.}

proc vrnaMdDefaultsNoLP_get*(): cint {.cdecl, importc: "vrna_md_defaults_noLP_get",
                                    importRna.}

proc vrnaMdDefaultsNoGU*(flag: cint) {.cdecl, importc: "vrna_md_defaults_noGU",
                                    importRna.}

proc vrnaMdDefaultsNoGU_get*(): cint {.cdecl, importc: "vrna_md_defaults_noGU_get",
                                    importRna.}

proc vrnaMdDefaultsNoGUclosure*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_noGUclosure", importRna.}

proc vrnaMdDefaultsNoGUclosureGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_noGUclosure_get", importRna.}

proc vrnaMdDefaultsLogML*(flag: cint) {.cdecl, importc: "vrna_md_defaults_logML",
                                     importRna.}

proc vrnaMdDefaultsLogML_get*(): cint {.cdecl,
                                     importc: "vrna_md_defaults_logML_get",
                                     importRna.}

proc vrnaMdDefaultsCirc*(flag: cint) {.cdecl, importc: "vrna_md_defaults_circ",
                                    importRna.}

proc vrnaMdDefaultsCircGet*(): cint {.cdecl, importc: "vrna_md_defaults_circ_get",
                                   importRna.}

proc vrnaMdDefaultsGquad*(flag: cint) {.cdecl, importc: "vrna_md_defaults_gquad",
                                     importRna.}

proc vrnaMdDefaultsGquadGet*(): cint {.cdecl, importc: "vrna_md_defaults_gquad_get",
                                    importRna.}

proc vrnaMdDefaultsUniqML*(flag: cint) {.cdecl, importc: "vrna_md_defaults_uniq_ML",
                                      importRna.}

proc vrnaMdDefaultsUniqML_get*(): cint {.cdecl,
                                      importc: "vrna_md_defaults_uniq_ML_get",
                                      importRna.}

proc vrnaMdDefaultsEnergySet*(e: cint) {.cdecl,
                                      importc: "vrna_md_defaults_energy_set",
                                      importRna.}

proc vrnaMdDefaultsEnergySetGet*(): cint {.cdecl, importc: "vrna_md_defaults_energy_set_get",
                                        importRna.}

proc vrnaMdDefaultsBacktrack*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_backtrack", importRna.}

proc vrnaMdDefaultsBacktrackGet*(): cint {.cdecl, importc: "vrna_md_defaults_backtrack_get",
                                        importRna.}

proc vrnaMdDefaultsBacktrackType*(t: char) {.cdecl,
    importc: "vrna_md_defaults_backtrack_type", importRna.}

proc vrnaMdDefaultsBacktrackTypeGet*(): char {.cdecl,
    importc: "vrna_md_defaults_backtrack_type_get", importRna.}

proc vrnaMdDefaultsComputeBpp*(flag: cint) {.cdecl,
    importc: "vrna_md_defaults_compute_bpp", importRna.}

proc vrnaMdDefaultsComputeBppGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_compute_bpp_get", importRna.}

proc vrnaMdDefaultsMaxBpSpan*(span: cint) {.cdecl,
    importc: "vrna_md_defaults_max_bp_span", importRna.}

proc vrnaMdDefaultsMaxBpSpanGet*(): cint {.cdecl, importc: "vrna_md_defaults_max_bp_span_get",
                                        importRna.}

proc vrnaMdDefaultsMinLoopSize*(size: cint) {.cdecl,
    importc: "vrna_md_defaults_min_loop_size", importRna.}

proc vrnaMdDefaultsMinLoopSizeGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_min_loop_size_get", importRna.}

proc vrnaMdDefaultsWindowSize*(size: cint) {.cdecl,
    importc: "vrna_md_defaults_window_size", importRna.}

proc vrnaMdDefaultsWindowSizeGet*(): cint {.cdecl,
    importc: "vrna_md_defaults_window_size_get", importRna.}

proc vrnaMdDefaultsOldAliEn*(flag: cint) {.cdecl,
                                        importc: "vrna_md_defaults_oldAliEn",
                                        importRna.}

proc vrnaMdDefaultsOldAliEnGet*(): cint {.cdecl, importc: "vrna_md_defaults_oldAliEn_get",
                                       importRna.}

proc vrnaMdDefaultsRibo*(flag: cint) {.cdecl, importc: "vrna_md_defaults_ribo",
                                    importRna.}

proc vrnaMdDefaultsRiboGet*(): cint {.cdecl, importc: "vrna_md_defaults_ribo_get",
                                   importRna.}

proc vrnaMdDefaultsCvFact*(factor: cdouble) {.cdecl,
    importc: "vrna_md_defaults_cv_fact", importRna.}

proc vrnaMdDefaultsCvFactGet*(): cdouble {.cdecl, importc: "vrna_md_defaults_cv_fact_get",
                                        importRna.}

proc vrnaMdDefaultsNcFact*(factor: cdouble) {.cdecl,
    importc: "vrna_md_defaults_nc_fact", importRna.}

proc vrnaMdDefaultsNcFactGet*(): cdouble {.cdecl, importc: "vrna_md_defaults_nc_fact_get",
                                        importRna.}

proc vrnaMdDefaultsSfact*(factor: cdouble) {.cdecl,
    importc: "vrna_md_defaults_sfact", importRna.}

proc vrnaMdDefaultsSfactGet*(): cdouble {.cdecl,
                                       importc: "vrna_md_defaults_sfact_get",
                                       importRna.}
