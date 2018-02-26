#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc lduplexfold*(s1: cstring; s2: cstring; threshold: cint; extensionCost: cint;
                 alignmentLength: cint; delta: cint; fast: cint; ilA: cint; ilB: cint;
                 bA: cint; bB: cint): ptr ptr DuplexT {.cdecl, importc: "Lduplexfold",
    importRna.}

proc lduplexfoldXS*(s1: cstring; s2: cstring; accessS1: ptr ptr cint;
                   accessS2: ptr ptr cint; threshold: cint; delta: cint;
                   alignmentLength: cint; fast: cint; ilA: cint; ilB: cint; bA: cint;
                   bB: cint): ptr ptr DuplexT {.cdecl, importc: "Lduplexfold_XS",
    importRna.}

proc lduplexfoldC*(s1: cstring; s2: cstring; threshold: cint; extensionCost: cint;
                  alignmentLength: cint; delta: cint; fast: cint; structure: cstring;
                  ilA: cint; ilB: cint; bA: cint; bB: cint): ptr ptr DuplexT {.cdecl,
    importc: "Lduplexfold_C", importRna.}

proc lduplexfoldCXS*(s1: cstring; s2: cstring; accessS1: ptr ptr cint;
                    accessS2: ptr ptr cint; threshold: cint; delta: cint;
                    alignmentLength: cint; fast: cint; structure: cstring; ilA: cint;
                    ilB: cint; bA: cint; bB: cint): ptr ptr DuplexT {.cdecl,
    importc: "Lduplexfold_CXS", importRna.}
