#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



type
  VrnaPathT* = vrnaPathS



type
  VrnaPathS* = object
    en*: cdouble
    s*: cstring



proc vrnaPathFindpathSaddle*(vc: ptr VrnaFoldCompoundT; struc1: cstring;
                            struc2: cstring; max: cint): cint {.cdecl,
    importc: "vrna_path_findpath_saddle", dynlib: rnaLib.}

proc vrnaPathFindpath*(vc: ptr VrnaFoldCompoundT; s1: cstring; s2: cstring;
                      maxkeep: cint): ptr VrnaPathT {.cdecl,
    importc: "vrna_path_findpath", dynlib: rnaLib.}
