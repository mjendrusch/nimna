#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc makeSwString*(string: cstring): ptr SwString {.cdecl, importc: "Make_swString",
    dynlib: rnaLib.}

proc stringEditDistance*(t1: ptr SwString; t2: ptr SwString): cfloat {.cdecl,
    importc: "string_edit_distance", dynlib: rnaLib.}
