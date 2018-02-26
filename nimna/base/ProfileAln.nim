#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc profileAln*(t1: ptr cfloat; seq1: cstring; t2: ptr cfloat; seq2: cstring): cfloat {.
    cdecl, importc: "profile_aln", importRna.}
proc setPalnParams*(gapOpen: cdouble; gapExt: cdouble; seqweight: cdouble;
                   freeEnds: cint): cint {.cdecl, importc: "set_paln_params",
                                        importRna.}
