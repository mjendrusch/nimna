#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc pf*(vc: ptr VrnaFoldCompoundT; structure: ptr char): cfloat {.cdecl,
    importc: "vrna_pf", dynlib: rnaLib.}

proc pfFold*(sequence: cstring; structure: ptr char; pl: ptr ptr VrnaPlistT): cfloat {.
    cdecl, importc: "vrna_pf_fold", dynlib: rnaLib.}

proc pfCircfold*(sequence: cstring; structure: ptr char; pl: ptr ptr VrnaPlistT): cfloat {.
    cdecl, importc: "vrna_pf_circfold", dynlib: rnaLib.}

proc pfFloatPrecision*(): cint {.cdecl, importc: "vrna_pf_float_precision",
                                  dynlib: rnaLib.}
