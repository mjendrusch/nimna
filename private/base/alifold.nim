

proc vrnaAlifold*(sequences: cstringArray; structure: cstring): cfloat {.cdecl,
    importc: "vrna_alifold", dynlib: rnaLib.}

proc vrnaCircalifold*(sequences: cstringArray; structure: cstring): cfloat {.cdecl,
    importc: "vrna_circalifold", dynlib: rnaLib.}

proc vrnaPfAlifold*(sequences: cstringArray; structure: cstring;
                   pl: ptr ptr VrnaPlistT): cfloat {.cdecl,
    importc: "vrna_pf_alifold", dynlib: rnaLib.}

proc vrnaPfCircalifold*(sequences: cstringArray; structure: cstring;
                       pl: ptr ptr VrnaPlistT): cfloat {.cdecl,
    importc: "vrna_pf_circalifold", dynlib: rnaLib.}