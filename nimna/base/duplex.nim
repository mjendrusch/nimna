#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc duplexfold*(s1: cstring; s2: cstring): DuplexT {.cdecl, importc: "duplexfold",
    importRna.}
proc duplexSubopt*(s1: cstring; s2: cstring; delta: cint; w: cint): ptr DuplexT {.cdecl,
    importc: "duplex_subopt", importRna.}
proc aliduplexfold*(s1: ptr cstring; s2: ptr cstring): DuplexT {.cdecl,
    importc: "aliduplexfold", importRna.}
proc aliduplexSubopt*(s1: ptr cstring; s2: ptr cstring; delta: cint; w: cint): ptr DuplexT {.
    cdecl, importc: "aliduplex_subopt", importRna.}
