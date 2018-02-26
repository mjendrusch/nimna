#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaCofold*(sequence: cstring; structure: cstring): cfloat {.cdecl,
    importc: "vrna_cofold", importRna.}
