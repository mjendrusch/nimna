#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaLfold*(string: cstring; windowSize: cint; file: ptr File): cfloat {.cdecl,
    importc: "vrna_Lfold", importRna.}

when defined(withSVM):
  proc vrnaLfoldz*(string: cstring; windowSize: cint; minZ: cdouble; file: ptr File): cfloat {.
      cdecl, importc: "vrna_Lfoldz", importRna.}

proc aliLfold*(strings: cstringArray; structure: cstring; maxdist: cint): cfloat {.
    cdecl, importc: "aliLfold", importRna.}
