#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaCentroid*(vc: ptr VrnaFoldCompoundT; dist: ptr cdouble): cstring {.cdecl,
    importc: "vrna_centroid", importRna.}
proc vrnaCentroidFromPlist*(length: cint; dist: ptr cdouble; pl: ptr VrnaPlistT): cstring {.
    cdecl, importc: "vrna_centroid_from_plist", importRna.}
proc vrnaCentroidFromProbs*(length: cint; dist: ptr cdouble; probs: ptr Flt_Or_Dbl): cstring {.
    cdecl, importc: "vrna_centroid_from_probs", importRna.}
