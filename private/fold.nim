#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



proc vrnaFold*(sequence: cstring; structure: cstring): cfloat {.cdecl,
    importc: "vrna_fold", dynlib: rnaLib.}

proc vrnaCircfold*(sequence: cstring; structure: cstring): cfloat {.cdecl,
    importc: "vrna_circfold", dynlib: rnaLib.}
