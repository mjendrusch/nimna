#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  plexHits* {.importc: "PlexHits", importRna.}: ptr DupVar
  plexHitsArrayLength* {.importc: "PlexHitsArrayLength", importRna.}: cint
  numberOfHits* {.importc: "NumberOfHits", importRna.}: cint
  verbose* {.importc: "verbose", importRna.}: cint


proc pKLduplexfoldXS*(s1: cstring; accessS1: ptr ptr cint; threshold: cint;
                     alignmentLength: cint; delta: cint): ptr ptr DupVar {.cdecl,
    importc: "PKLduplexfold_XS", importRna.}
proc arraySize*(array: ptr ptr DuplexT): cint {.cdecl, importc: "arraySize",
    importRna.}
proc freeDuplexT*(array: ptr ptr DuplexT) {.cdecl, importc: "freeDuplexT",
                                       importRna.}
