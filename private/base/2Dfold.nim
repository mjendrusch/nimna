proc vrnaMfeTwoD*(vc: ptr VrnaFoldCompoundT; distance1: cint; distance2: cint): ptr VrnaSolTwoD_t {.
    cdecl, importc: "vrna_mfe_TwoD", dynlib: rnaLib.}

proc vrnaBacktrack5TwoD*(vc: ptr VrnaFoldCompoundT; k: cint; l: cint; j: cuint): cstring {.
    cdecl, importc: "vrna_backtrack5_TwoD", dynlib: rnaLib.}
