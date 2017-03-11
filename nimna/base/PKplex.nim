#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  plexHits* {.importc: "PlexHits", dynlib: rnaLib.}: ptr DupVar
  plexHitsArrayLength* {.importc: "PlexHitsArrayLength", dynlib: rnaLib.}: cint
  numberOfHits* {.importc: "NumberOfHits", dynlib: rnaLib.}: cint
  verbose* {.importc: "verbose", dynlib: rnaLib.}: cint


proc pKLduplexfoldXS*(s1: cstring; accessS1: ptr ptr cint; threshold: cint;
                     alignmentLength: cint; delta: cint): ptr ptr DupVar {.cdecl,
    importc: "PKLduplexfold_XS", dynlib: rnaLib.}
proc arraySize*(array: ptr ptr DuplexT): cint {.cdecl, importc: "arraySize",
    dynlib: rnaLib.}
proc freeDuplexT*(array: ptr ptr DuplexT) {.cdecl, importc: "freeDuplexT",
                                       dynlib: rnaLib.}
