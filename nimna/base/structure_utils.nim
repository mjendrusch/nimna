#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaDbPack*(struc: cstring): cstring {.cdecl, importc: "vrna_db_pack",
                                        importRna.}

proc vrnaDbUnpack*(packed: cstring): cstring {.cdecl, importc: "vrna_db_unpack",
    importRna.}

proc vrnaPtable*(structure: cstring): ptr cshort {.cdecl, importc: "vrna_ptable",
    importRna.}

proc vrnaPtPkGet*(structure: cstring): ptr cshort {.cdecl, importc: "vrna_pt_pk_get",
    importRna.}

proc vrnaPtableCopy*(pt: ptr cshort): ptr cshort {.cdecl, importc: "vrna_ptable_copy",
    importRna.}

proc vrnaPtAliGet*(structure: cstring): ptr cshort {.cdecl,
    importc: "vrna_pt_ali_get", importRna.}

proc vrnaPtSnoopGet*(structure: cstring): ptr cshort {.cdecl,
    importc: "vrna_pt_snoop_get", importRna.}

proc vrnaLoopidxFromPtable*(pt: ptr cshort): ptr cint {.cdecl,
    importc: "vrna_loopidx_from_ptable", importRna.}

proc vrnaDbFromPtable*(pt: ptr cshort): cstring {.cdecl,
    importc: "vrna_db_from_ptable", importRna.}

proc vrnaBpDistance*(str1: cstring; str2: cstring): cint {.cdecl,
    importc: "vrna_bp_distance", importRna.}

proc vrnaRefBPcntMatrix*(referencePt: ptr cshort; turn: cuint): ptr cuint {.cdecl,
    importc: "vrna_refBPcnt_matrix", importRna.}

proc vrnaRefBPdistMatrix*(pt1: ptr cshort; pt2: ptr cshort; turn: cuint): ptr cuint {.
    cdecl, importc: "vrna_refBPdist_matrix", importRna.}

proc vrnaDbFromProbs*(pr: ptr Flt_Or_Dbl; length: cuint): cstring {.cdecl,
    importc: "vrna_db_from_probs", importRna.}

proc vrnaBppSymbol*(x: ptr cfloat): char {.cdecl, importc: "vrna_bpp_symbol",
                                      importRna.}

proc vrnaDbFromBpStack*(bp: ptr VrnaBpStackT; length: cuint): cstring {.cdecl,
    importc: "vrna_db_from_bp_stack", importRna.}
proc vrnaLetterStructure*(structure: cstring; bp: ptr VrnaBpStackT; length: cuint) {.
    cdecl, importc: "vrna_letter_structure", importRna.}

proc vrnaPlist*(struc: cstring; pr: cfloat): ptr VrnaPlistT {.cdecl,
    importc: "vrna_plist", importRna.}

proc vrnaPlistFromProbs*(vc: ptr VrnaFoldCompoundT; cutOff: cdouble): ptr VrnaPlistT {.
    cdecl, importc: "vrna_plist_from_probs", importRna.}

proc vrnaDbFromPlist*(pairs: ptr VrnaPlistT; n: cuint): cstring {.cdecl,
    importc: "vrna_db_from_plist", importRna.}
proc vrnaDbToElementString*(structure: cstring): cstring {.cdecl,
    importc: "vrna_db_to_element_string", importRna.}
proc vrnaHxFromPtable*(pt: ptr cshort): ptr VrnaHxT {.cdecl,
    importc: "vrna_hx_from_ptable", importRna.}
proc vrnaHxMerge*(list: ptr VrnaHxT; maxdist: cint): ptr VrnaHxT {.cdecl,
    importc: "vrna_hx_merge", importRna.}
