#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaDbPack*(struc: cstring): cstring {.cdecl, importc: "vrna_db_pack",
                                        dynlib: rnaLib.}

proc vrnaDbUnpack*(packed: cstring): cstring {.cdecl, importc: "vrna_db_unpack",
    dynlib: rnaLib.}

proc vrnaPtable*(structure: cstring): ptr cshort {.cdecl, importc: "vrna_ptable",
    dynlib: rnaLib.}

proc vrnaPtPkGet*(structure: cstring): ptr cshort {.cdecl, importc: "vrna_pt_pk_get",
    dynlib: rnaLib.}

proc vrnaPtableCopy*(pt: ptr cshort): ptr cshort {.cdecl, importc: "vrna_ptable_copy",
    dynlib: rnaLib.}

proc vrnaPtAliGet*(structure: cstring): ptr cshort {.cdecl,
    importc: "vrna_pt_ali_get", dynlib: rnaLib.}

proc vrnaPtSnoopGet*(structure: cstring): ptr cshort {.cdecl,
    importc: "vrna_pt_snoop_get", dynlib: rnaLib.}

proc vrnaLoopidxFromPtable*(pt: ptr cshort): ptr cint {.cdecl,
    importc: "vrna_loopidx_from_ptable", dynlib: rnaLib.}

proc vrnaDbFromPtable*(pt: ptr cshort): cstring {.cdecl,
    importc: "vrna_db_from_ptable", dynlib: rnaLib.}

proc vrnaBpDistance*(str1: cstring; str2: cstring): cint {.cdecl,
    importc: "vrna_bp_distance", dynlib: rnaLib.}

proc vrnaRefBPcntMatrix*(referencePt: ptr cshort; turn: cuint): ptr cuint {.cdecl,
    importc: "vrna_refBPcnt_matrix", dynlib: rnaLib.}

proc vrnaRefBPdistMatrix*(pt1: ptr cshort; pt2: ptr cshort; turn: cuint): ptr cuint {.
    cdecl, importc: "vrna_refBPdist_matrix", dynlib: rnaLib.}

proc vrnaDbFromProbs*(pr: ptr Flt_Or_Dbl; length: cuint): cstring {.cdecl,
    importc: "vrna_db_from_probs", dynlib: rnaLib.}

proc vrnaBppSymbol*(x: ptr cfloat): char {.cdecl, importc: "vrna_bpp_symbol",
                                      dynlib: rnaLib.}

proc vrnaDbFromBpStack*(bp: ptr VrnaBpStackT; length: cuint): cstring {.cdecl,
    importc: "vrna_db_from_bp_stack", dynlib: rnaLib.}
proc vrnaLetterStructure*(structure: cstring; bp: ptr VrnaBpStackT; length: cuint) {.
    cdecl, importc: "vrna_letter_structure", dynlib: rnaLib.}

proc vrnaPlist*(struc: cstring; pr: cfloat): ptr VrnaPlistT {.cdecl,
    importc: "vrna_plist", dynlib: rnaLib.}

proc vrnaPlistFromProbs*(vc: ptr VrnaFoldCompoundT; cutOff: cdouble): ptr VrnaPlistT {.
    cdecl, importc: "vrna_plist_from_probs", dynlib: rnaLib.}

proc vrnaDbFromPlist*(pairs: ptr VrnaPlistT; n: cuint): cstring {.cdecl,
    importc: "vrna_db_from_plist", dynlib: rnaLib.}
proc vrnaDbToElementString*(structure: cstring): cstring {.cdecl,
    importc: "vrna_db_to_element_string", dynlib: rnaLib.}
proc vrnaHxFromPtable*(pt: ptr cshort): ptr VrnaHxT {.cdecl,
    importc: "vrna_hx_from_ptable", dynlib: rnaLib.}
proc vrnaHxMerge*(list: ptr VrnaHxT; maxdist: cint): ptr VrnaHxT {.cdecl,
    importc: "vrna_hx_merge", dynlib: rnaLib.}
