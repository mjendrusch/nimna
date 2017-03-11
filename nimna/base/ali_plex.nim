#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc aliLduplexfold*(s1: ptr cstring; s2: ptr cstring; threshold: cint;
                    extensionCost: cint; alignmentLength: cint; delta: cint;
                    fast: cint; ilA: cint; ilB: cint; bA: cint; bB: cint): ptr ptr DuplexT {.
    cdecl, importc: "aliLduplexfold", dynlib: rnaLib.}

proc aliLduplexfoldXS*(s1: ptr cstring; s2: ptr cstring; accessS1: ptr ptr cint;
                      accessS2: ptr ptr cint; threshold: cint; alignmentLength: cint;
                      delta: cint; fast: cint; ilA: cint; ilB: cint; bA: cint; bB: cint): ptr ptr DuplexT {.
    cdecl, importc: "aliLduplexfold_XS", dynlib: rnaLib.}
