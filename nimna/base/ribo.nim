#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc getRibosum*(alseq: cstringArray; nSeq: cint; length: cint): ptr ptr cfloat {.cdecl,
    importc: "get_ribosum", dynlib: rnaLib.}

proc readribosum*(name: cstring): ptr ptr cfloat {.cdecl, importc: "readribosum",
    dynlib: rnaLib.}
