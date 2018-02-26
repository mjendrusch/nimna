#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaScAddHiMotif*(vc: ptr VrnaFoldCompoundT; seq: cstring; structure: cstring;
                      energy: Flt_Or_Dbl; options: cuint): cint {.cdecl,
    importc: "vrna_sc_add_hi_motif", importRna.}
proc vrnaScLigandDetectMotifs*(vc: ptr VrnaFoldCompoundT; structure: cstring): ptr VrnaScMotifT {.
    cdecl, importc: "vrna_sc_ligand_detect_motifs", importRna.}
proc vrnaScGetHiMotif*(vc: ptr VrnaFoldCompoundT; i: ptr cint; j: ptr cint; k: ptr cint;
                      l: ptr cint): cint {.cdecl, importc: "vrna_sc_get_hi_motif",
                                       importRna.}
