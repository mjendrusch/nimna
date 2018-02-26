#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc updatePfParamsLP*(length: cint) {.cdecl, importc: "update_pf_paramsLP",
                                    importRna.}

proc updatePfParamsLP_par*(length: cint; parameters: ptr VrnaExpParamT) {.cdecl,
    importc: "update_pf_paramsLP_par", importRna.}

proc pflFold*(sequence: cstring; winSize: cint; pairSize: cint; cutoffb: cfloat;
             pU: ptr ptr cdouble; dpp2: ptr ptr VrnaPlistT; pUfp: ptr File; spup: ptr File): ptr VrnaPlistT {.
    cdecl, importc: "pfl_fold", importRna.}

proc pflFoldPar*(sequence: cstring; winSize: cint; pairSize: cint; cutoffb: cfloat;
                pU: ptr ptr cdouble; dpp2: ptr ptr VrnaPlistT; pUfp: ptr File; spup: ptr File;
                parameters: ptr VrnaExpParamT): ptr VrnaPlistT {.cdecl,
    importc: "pfl_fold_par", importRna.}
proc putoutpU_probPar*(pU: ptr ptr cdouble; length: cint; ulength: cint; fp: ptr File;
                      energies: cint; parameters: ptr VrnaExpParamT) {.cdecl,
    importc: "putoutpU_prob_par", importRna.}

proc putoutpU_prob*(pU: ptr ptr cdouble; length: cint; ulength: cint; fp: ptr File;
                   energies: cint) {.cdecl, importc: "putoutpU_prob", importRna.}
proc putoutpU_probBinPar*(pU: ptr ptr cdouble; length: cint; ulength: cint; fp: ptr File;
                         energies: cint; parameters: ptr VrnaExpParamT) {.cdecl,
    importc: "putoutpU_prob_bin_par", importRna.}

proc putoutpU_probBin*(pU: ptr ptr cdouble; length: cint; ulength: cint; fp: ptr File;
                      energies: cint) {.cdecl, importc: "putoutpU_prob_bin",
                                      importRna.}
