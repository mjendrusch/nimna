#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaParams*(md: ptr VrnaMdT): ptr VrnaParamT {.cdecl, importc: "vrna_params",
    dynlib: rnaLib.}

proc vrnaParamsCopy*(par: ptr VrnaParamT): ptr VrnaParamT {.cdecl,
    importc: "vrna_params_copy", dynlib: rnaLib.}

proc vrnaExpParams*(md: ptr VrnaMdT): ptr VrnaExpParamT {.cdecl,
    importc: "vrna_exp_params", dynlib: rnaLib.}

proc vrnaExpParamsComparative*(nSeq: cuint; md: ptr VrnaMdT): ptr VrnaExpParamT {.cdecl,
    importc: "vrna_exp_params_comparative", dynlib: rnaLib.}

proc vrnaExpParamsCopy*(par: ptr VrnaExpParamT): ptr VrnaExpParamT {.cdecl,
    importc: "vrna_exp_params_copy", dynlib: rnaLib.}

proc vrnaParamsSubst*(vc: ptr VrnaFoldCompoundT; par: ptr VrnaParamT) {.cdecl,
    importc: "vrna_params_subst", dynlib: rnaLib.}

proc vrnaExpParamsSubst*(vc: ptr VrnaFoldCompoundT; params: ptr VrnaExpParamT) {.cdecl,
    importc: "vrna_exp_params_subst", dynlib: rnaLib.}

proc vrnaExpParamsRescale*(vc: ptr VrnaFoldCompoundT; mfe: ptr cdouble) {.cdecl,
    importc: "vrna_exp_params_rescale", dynlib: rnaLib.}

proc vrnaParamsReset*(vc: ptr VrnaFoldCompoundT; mdP: ptr VrnaMdT) {.cdecl,
    importc: "vrna_params_reset", dynlib: rnaLib.}

proc vrnaExpParamsReset*(vc: ptr VrnaFoldCompoundT; mdP: ptr VrnaMdT) {.cdecl,
    importc: "vrna_exp_params_reset", dynlib: rnaLib.}
