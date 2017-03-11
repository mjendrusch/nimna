#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc mea*(p: ptr VrnaPlistT; structure: cstring; gamma: cdouble): cfloat {.cdecl,
    importc: "MEA", dynlib: rnaLib.}
proc meaSeq*(p: ptr VrnaPlistT; sequence: cstring; structure: cstring; gamma: cdouble;
             pf: ptr VrnaExpParamT): cfloat {.cdecl, importc: "MEA_seq", dynlib: rnaLib.}
