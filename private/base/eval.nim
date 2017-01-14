#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.




var cutPoint* {.importc: "cut_point", dynlib: rnaLib.}: cint


var eosDebug* {.importc: "eos_debug", dynlib: rnaLib.}: cint


proc vrnaEvalStructure*(vc: ptr VrnaFoldCompoundT; structure: cstring): cfloat {.cdecl,
    importc: "vrna_eval_structure", dynlib: rnaLib.}

proc vrnaEvalCovarStructure*(vc: ptr VrnaFoldCompoundT; structure: cstring): cfloat {.
    cdecl, importc: "vrna_eval_covar_structure", dynlib: rnaLib.}

proc vrnaEvalStructureSimple*(string: cstring; structure: cstring): cfloat {.cdecl,
    importc: "vrna_eval_structure_simple", dynlib: rnaLib.}

proc vrnaEvalStructureVerbose*(vc: ptr VrnaFoldCompoundT; structure: cstring;
                              file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_verbose", dynlib: rnaLib.}

proc vrnaEvalStructureV*(vc: ptr VrnaFoldCompoundT; structure: cstring;
                        verbosityLevel: cint; file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_v", dynlib: rnaLib.}

proc vrnaEvalStructureSimpleVerbose*(string: cstring; structure: cstring;
                                    file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_simple_verbose", dynlib: rnaLib.}

proc vrnaEvalStructureSimpleV*(string: cstring; structure: cstring;
                              verbosityLevel: cint; file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_simple_v", dynlib: rnaLib.}

proc vrnaEvalStructurePt*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort): cint {.cdecl,
    importc: "vrna_eval_structure_pt", dynlib: rnaLib.}

proc vrnaEvalStructurePtSimple*(string: cstring; pt: ptr cshort): cint {.cdecl,
    importc: "vrna_eval_structure_pt_simple", dynlib: rnaLib.}

proc vrnaEvalStructurePtVerbose*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort;
                                file: ptr File): cint {.cdecl,
    importc: "vrna_eval_structure_pt_verbose", dynlib: rnaLib.}

proc vrnaEvalStructurePtV*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort;
                          verbosityLevel: cint; file: ptr File): cint {.cdecl,
    importc: "vrna_eval_structure_pt_v", dynlib: rnaLib.}

proc vrnaEvalStructurePtSimpleVerbose*(string: cstring; pt: ptr cshort; file: ptr File): cint {.
    cdecl, importc: "vrna_eval_structure_pt_simple_verbose", dynlib: rnaLib.}

proc vrnaEvalStructurePtSimpleV*(string: cstring; pt: ptr cshort;
                                verbosityLevel: cint; file: ptr File): cint {.cdecl,
    importc: "vrna_eval_structure_pt_simple_v", dynlib: rnaLib.}

proc vrnaEvalLoopPt*(vc: ptr VrnaFoldCompoundT; i: cint; pt: ptr cshort): cint {.cdecl,
    importc: "vrna_eval_loop_pt", dynlib: rnaLib.}

proc vrnaEvalMove*(vc: ptr VrnaFoldCompoundT; structure: cstring; m1: cint; m2: cint): cfloat {.
    cdecl, importc: "vrna_eval_move", dynlib: rnaLib.}

proc vrnaEvalMovePt*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort; m1: cint; m2: cint): cint {.
    cdecl, importc: "vrna_eval_move_pt", dynlib: rnaLib.}
proc vrnaEvalMovePtSimple*(string: cstring; pt: ptr cshort; m1: cint; m2: cint): cint {.
    cdecl, importc: "vrna_eval_move_pt_simple", dynlib: rnaLib.}
