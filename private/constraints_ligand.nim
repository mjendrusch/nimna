#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



type
  VrnaScMotifT* = vrnaScMotifS
  VrnaScMotifS* = object
    i*: cint
    j*: cint
    k*: cint
    l*: cint
    number*: cint



proc vrnaScAddHiMotif*(vc: ptr VrnaFoldCompoundT; seq: cstring; structure: cstring;
                      energy: Flt_Or_Dbl; options: cuint): cint {.cdecl,
    importc: "vrna_sc_add_hi_motif", dynlib: rnaLib.}
proc vrnaScLigandDetectMotifs*(vc: ptr VrnaFoldCompoundT; structure: cstring): ptr VrnaScMotifT {.
    cdecl, importc: "vrna_sc_ligand_detect_motifs", dynlib: rnaLib.}
proc vrnaScGetHiMotif*(vc: ptr VrnaFoldCompoundT; i: ptr cint; j: ptr cint; k: ptr cint;
                      l: ptr cint): cint {.cdecl, importc: "vrna_sc_get_hi_motif",
                                       dynlib: rnaLib.}