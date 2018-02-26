#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc mfe*(vc: ptr VrnaFoldCompoundT; structure: cstring): cfloat {.cdecl,
    importc: "vrna_mfe", importRna.}

proc mfeDimer*(vc: ptr VrnaFoldCompoundT; structure: cstring): cfloat {.cdecl,
    importc: "vrna_mfe_dimer", importRna.}

proc mfeWindow*(vc: ptr VrnaFoldCompoundT; file: File): cfloat {.cdecl,
    importc: "vrna_mfe_window", importRna.}

#proc vrnaBacktrackFromIntervals*(vc: ptr VrnaFoldCompoundT;
#                                bpStack: ptr VrnaBpStackT; btStack: ptr Sect; s: cint) {.
#    cdecl, importc: "vrna_backtrack_from_intervals", importRna.}
