proc mea*(p: ptr VrnaPlistT; structure: cstring; gamma: cdouble): cfloat {.cdecl,
    importc: "MEA", dynlib: rnaLib.}
proc meaSeq*(p: ptr VrnaPlistT; sequence: cstring; structure: cstring; gamma: cdouble;
             pf: ptr VrnaExpParamT): cfloat {.cdecl, importc: "MEA_seq", dynlib: rnaLib.}
