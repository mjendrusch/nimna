

proc vrnaE_hpLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): cint {.cdecl,
    importc: "vrna_E_hp_loop", dynlib: rnaLib.}

proc vrnaE_extHpLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): cint {.cdecl,
    importc: "vrna_E_ext_hp_loop", dynlib: rnaLib.}

proc vrnaEvalExtHpLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): cint {.cdecl,
    importc: "vrna_eval_ext_hp_loop", dynlib: rnaLib.}

proc vrnaEvalHpLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint): cint {.cdecl,
    importc: "vrna_eval_hp_loop", dynlib: rnaLib.}

proc vrnaBT_hpLoop*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; en: cint;
                   bpStack: ptr VrnaBpStackT; stackCount: ptr cint): cint {.cdecl,
    importc: "vrna_BT_hp_loop", dynlib: rnaLib.}