#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var snoopSuboptSorted* {.importc: "snoop_subopt_sorted", dynlib: rnaLib.}: cint

proc snoopfold*(s1: cstring; s2: cstring; penalty: cint; threshloop: cint;
               threshLE: cint; threshRE: cint; threshDE: cint; threshD: cint;
               halfStem: cint; maxHalfStem: cint; minS2: cint; maxS2: cint; minS1: cint;
               maxS1: cint; minD1: cint; minD2: cint; fullStemEnergy: cint): SnoopT {.
    cdecl, importc: "snoopfold", dynlib: rnaLib.}

proc snoopSubopt*(s1: cstring; s2: cstring; delta: cint; w: cint; penalty: cint;
                 threshloop: cint; threshLE: cint; threshRE: cint; threshDE: cint;
                 threshTE: cint; threshSE: cint; threshD: cint; distance: cint;
                 halfStem: cint; maxHalfStem: cint; minS2: cint; maxS2: cint;
                 minS1: cint; maxS1: cint; minD1: cint; minD2: cint;
                 fullStemEnergy: cint): ptr SnoopT {.cdecl, importc: "snoop_subopt",
    dynlib: rnaLib.}

proc lsnoopSubopt*(s1: cstring; s2: cstring; delta: cint; w: cint; penalty: cint;
                  threshloop: cint; threshLE: cint; threshRE: cint; threshDE: cint;
                  threshTE: cint; threshSE: cint; threshD: cint; distance: cint;
                  halfStem: cint; maxHalfStem: cint; minS2: cint; maxS2: cint;
                  minS1: cint; maxS1: cint; minD1: cint; minD2: cint;
                  alignmentLength: cint; name: cstring; fullStemEnergy: cint) {.cdecl,
    importc: "Lsnoop_subopt", dynlib: rnaLib.}

proc lsnoopSuboptList*(s1: cstring; s2: cstring; delta: cint; w: cint; penalty: cint;
                      threshloop: cint; threshLE: cint; threshRE: cint;
                      threshDE: cint; threshTE: cint; threshSE: cint; threshD: cint;
                      distance: cint; halfStem: cint; maxHalfStem: cint; minS2: cint;
                      maxS2: cint; minS1: cint; maxS1: cint; minD1: cint; minD2: cint;
                      alignmentLength: cint; name: cstring; fullStemEnergy: cint) {.
    cdecl, importc: "Lsnoop_subopt_list", dynlib: rnaLib.}

proc lsnoopSuboptListXS*(s1: cstring; s2: cstring; accessS1: ptr ptr cint; delta: cint;
                        w: cint; penalty: cint; threshloop: cint; threshLE: cint;
                        threshRE: cint; threshDE: cint; threshTE: cint;
                        threshSE: cint; threshD: cint; distance: cint; halfStem: cint;
                        maxHalfStem: cint; minS2: cint; maxS2: cint; minS1: cint;
                        maxS1: cint; minD1: cint; minD2: cint; alignmentLength: cint;
                        name: cstring; fullStemEnergy: cint) {.cdecl,
    importc: "Lsnoop_subopt_list_XS", dynlib: rnaLib.}

proc snoopSuboptXS*(s1: cstring; s2: cstring; accessS1: ptr ptr cint; delta: cint; w: cint;
                   penalty: cint; threshloop: cint; threshLE: cint; threshRE: cint;
                   threshDE: cint; threshTE: cint; threshSE: cint; threshD: cint;
                   distance: cint; halfStem: cint; maxHalfStem: cint; minS2: cint;
                   maxS2: cint; minS1: cint; maxS1: cint; minD1: cint; minD2: cint;
                   alignmentLength: cint; name: cstring; fullStemEnergy: cint) {.
    cdecl, importc: "snoop_subopt_XS", dynlib: rnaLib.}

proc alisnoopSubopt*(s1: cstringArray; s2: cstringArray; delta: cint; w: cint;
                    penalty: cint; threshloop: cint; threshLE: cint; threshRE: cint;
                    threshDE: cint; threshTE: cint; threshSE: cint; threshD: cint;
                    distance: cint; halfStem: cint; maxHalfStem: cint; minS2: cint;
                    maxS2: cint; minS1: cint; maxS1: cint; minD1: cint; minD2: cint): ptr SnoopT {.
    cdecl, importc: "alisnoop_subopt", dynlib: rnaLib.}

proc aliLsnoopSuboptList*(s1: cstringArray; s2: cstringArray; delta: cint; w: cint;
                         penalty: cint; threshloop: cint; threshLE: cint;
                         threshRE: cint; threshDE: cint; threshTE: cint;
                         threshSE: cint; threshD: cint; distance: cint;
                         halfStem: cint; maxHalfStem: cint; minS2: cint; maxS2: cint;
                         minS1: cint; maxS1: cint; minD1: cint; minD2: cint;
                         alignmentLength: cint): ptr SnoopT {.cdecl,
    importc: "aliLsnoop_subopt_list", dynlib: rnaLib.}

proc alisnoopfold*(s1: cstringArray; s2: cstringArray; penalty: cint; threshloop: cint;
                  threshLE: cint; threshRE: cint; threshDE: cint; threshD: cint;
                  halfStem: cint; maxHalfStem: cint; minS2: cint; maxS2: cint;
                  minS1: cint; maxS1: cint; minD1: cint; minD2: cint): SnoopT {.cdecl,
    importc: "alisnoopfold", dynlib: rnaLib.}

proc snoopfoldXS*(s1: cstring; s2: cstring; accessS1: ptr ptr cint; pos: cint;
                 maxPosJ: cint; penalty: cint; threshloop: cint; threshLE: cint;
                 threshRE: cint; threshDE: cint; threshD: cint; halfStem: cint;
                 maxHalfStem: cint; minS2: cint; maxS2: cint; minS1: cint; maxS1: cint;
                 minD1: cint; minD2: cint; fullStemEnergy: cint): SnoopT {.cdecl,
    importc: "snoopfold_XS", dynlib: rnaLib.}
