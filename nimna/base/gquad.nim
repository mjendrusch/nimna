#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc e_gquad*(L: cint; lIdx: array[3, cint]; p: ptr VrnaParamT): cint {.cdecl,
    importc: "E_gquad", dynlib: rnaLib.}
proc expE_gquad*(L: cint; lIdx: array[3, cint]; pf: ptr VrnaExpParamT): Flt_Or_Dbl {.cdecl,
    importc: "exp_E_gquad", dynlib: rnaLib.}
proc e_gquadAli*(i: cint; L: cint; lIdx: array[3, cint]; s: ptr ptr cshort; nSeq: cint;
                p: ptr VrnaParamT): cint {.cdecl, importc: "E_gquad_ali",
                                       dynlib: rnaLib.}
proc e_gquadAliEn*(i: cint; L: cint; lIdx: array[3, cint]; s: ptr ptr cshort; nSeq: cint;
                  en: array[2, cint]; p: ptr VrnaParamT) {.cdecl,
    importc: "E_gquad_ali_en", dynlib: rnaLib.}

proc getGquadMatrix*(s: ptr cshort; p: ptr VrnaParamT): ptr cint {.cdecl,
    importc: "get_gquad_matrix", dynlib: rnaLib.}
proc getGquadAliMatrix*(s_cons: ptr cshort; s: ptr ptr cshort; nSeq: cint;
                       p: ptr VrnaParamT): ptr cint {.cdecl,
    importc: "get_gquad_ali_matrix", dynlib: rnaLib.}
proc getGquadPfMatrix*(s: ptr cshort; scale: ptr Flt_Or_Dbl; pf: ptr VrnaExpParamT): ptr Flt_Or_Dbl {.
    cdecl, importc: "get_gquad_pf_matrix", dynlib: rnaLib.}
proc getGquadL_matrix*(s: ptr cshort; start: cint; maxdist: cint; n: cint;
                      g: ptr ptr cint; p: ptr VrnaParamT): ptr ptr cint {.cdecl,
    importc: "get_gquad_L_matrix", dynlib: rnaLib.}
proc vrnaGquadMxLocalUpdate*(vc: ptr VrnaFoldCompoundT; start: cint) {.cdecl,
    importc: "vrna_gquad_mx_local_update", dynlib: rnaLib.}
proc getGquadPatternMfe*(s: ptr cshort; i: cint; j: cint; p: ptr VrnaParamT; L: ptr cint;
                        lIdx: array[3, cint]) {.cdecl,
    importc: "get_gquad_pattern_mfe", dynlib: rnaLib.}
proc getGquadPatternExhaustive*(s: ptr cshort; i: cint; j: cint; p: ptr VrnaParamT;
                               L: ptr cint; lIdx: ptr cint; threshold: cint) {.cdecl,
    importc: "get_gquad_pattern_exhaustive", dynlib: rnaLib.}
proc getGquadPatternPf*(s: ptr cshort; i: cint; j: cint; pf: ptr VrnaExpParamT;
                       L: ptr cint; lIdx: array[3, cint]) {.cdecl,
    importc: "get_gquad_pattern_pf", dynlib: rnaLib.}
proc getPlistGquadFromPr*(s: ptr cshort; gi: cint; gj: cint; g: ptr Flt_Or_Dbl;
                         probs: ptr Flt_Or_Dbl; scale: ptr Flt_Or_Dbl;
                         pf: ptr VrnaExpParamT): ptr VrnaPlistT {.cdecl,
    importc: "get_plist_gquad_from_pr", dynlib: rnaLib.}
proc getPlistGquadFromPrMax*(s: ptr cshort; gi: cint; gj: cint; g: ptr Flt_Or_Dbl;
                            probs: ptr Flt_Or_Dbl; scale: ptr Flt_Or_Dbl; L: ptr cint;
                            lIdx: array[3, cint]; pf: ptr VrnaExpParamT): ptr VrnaPlistT {.
    cdecl, importc: "get_plist_gquad_from_pr_max", dynlib: rnaLib.}
proc getPlistGquadFromDb*(structure: cstring; pr: cfloat): ptr VrnaPlistT {.cdecl,
    importc: "get_plist_gquad_from_db", dynlib: rnaLib.}
proc getGquadCount*(s: ptr cshort; i: cint; j: cint): cint {.cdecl,
    importc: "get_gquad_count", dynlib: rnaLib.}
proc getGquadLayerCount*(s: ptr cshort; i: cint; j: cint): cint {.cdecl,
    importc: "get_gquad_layer_count", dynlib: rnaLib.}

proc parseGquad*(struc: cstring; L: ptr cint; lIdx: array[3, cint]): cint {.cdecl,
    importc: "parse_gquad", dynlib: rnaLib.}
