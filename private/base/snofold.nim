#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  MISMATCH* = 3

proc snofold*(sequence: cstring; structure: cstring; maxAssym: cint; threshold: cint;
             minS2: cint; maxS2: cint; halfStem: cint; maxHalfStem: cint): cint {.cdecl,
    importc: "snofold", dynlib: rnaLib.}

proc snofreeArrays*(length: cint) {.cdecl, importc: "snofree_arrays", dynlib: rnaLib.}

proc snoinitializeFold*(length: cint) {.cdecl, importc: "snoinitialize_fold",
                                     dynlib: rnaLib.}

proc snoupdateFoldParams*() {.cdecl, importc: "snoupdate_fold_params", dynlib: rnaLib.}

proc snoloopEnergy*(ptable: ptr cshort; s: ptr cshort; s1: ptr cshort; i: cint): cint {.
    cdecl, importc: "snoloop_energy", dynlib: rnaLib.}
proc snoexportFoldArrays*(indxP: ptr ptr cint; mLoopP: ptr ptr cint; cLoop: ptr ptr cint;
                         foldP: ptr ptr ptr Folden; foldPXS: ptr ptr ptr Folden) {.cdecl,
    importc: "snoexport_fold_arrays", dynlib: rnaLib.}
proc snobacktrackFoldFromPair*(sequence: cstring; i: cint; j: cint): cstring {.cdecl,
    importc: "snobacktrack_fold_from_pair", dynlib: rnaLib.}

proc alisnofold*(strings: cstringArray; maxAssym: cint; threshloop: cint; minS2: cint;
                maxS2: cint; halfStem: cint; maxHalfStem: cint): cfloat {.cdecl,
    importc: "alisnofold", dynlib: rnaLib.}
proc alisnofreeArrays*(length: cint) {.cdecl, importc: "alisnofree_arrays",
                                    dynlib: rnaLib.}
proc alisnobacktrackFoldFromPair*(sequence: cstringArray; i: cint; j: cint;
                                 cov: ptr cint): cstring {.cdecl,
    importc: "alisnobacktrack_fold_from_pair", dynlib: rnaLib.}
var cvFact* {.importc: "cv_fact", dynlib: rnaLib.}: cdouble

var ncFact* {.importc: "nc_fact", dynlib: rnaLib.}: cdouble
