#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaPfTwoD*(vc: ptr VrnaFoldCompoundT; maxDistance1: cint; maxDistance2: cint): ptr VrnaSolTwoD_pfT {.
    cdecl, importc: "vrna_pf_TwoD", dynlib: rnaLib.}

proc vrnaPbacktrackTwoD*(vc: ptr VrnaFoldCompoundT; d1: cint; d2: cint): cstring {.cdecl,
    importc: "vrna_pbacktrack_TwoD", dynlib: rnaLib.}

proc vrnaPbacktrack5TwoD*(vc: ptr VrnaFoldCompoundT; d1: cint; d2: cint; length: cuint): cstring {.
    cdecl, importc: "vrna_pbacktrack5_TwoD", dynlib: rnaLib.}
