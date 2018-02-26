#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  cutPoint* {.importc: "cut_point", importRna.}: cint
  eosDebug* {.importc: "eos_debug", importRna.}: cint

proc vrnaEvalStructure*(vc: ptr VrnaFoldCompoundT; structure: cstring): cfloat {.cdecl,
    importc: "vrna_eval_structure", importRna.}

proc vrnaEvalCovarStructure*(vc: ptr VrnaFoldCompoundT; structure: cstring): cfloat {.
    cdecl, importc: "vrna_eval_covar_structure", importRna.}

proc vrnaEvalStructureSimple*(string: cstring; structure: cstring): cfloat {.cdecl,
    importc: "vrna_eval_structure_simple", importRna.}

proc vrnaEvalStructureVerbose*(vc: ptr VrnaFoldCompoundT; structure: cstring;
                              file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_verbose", importRna.}

proc vrnaEvalStructureV*(vc: ptr VrnaFoldCompoundT; structure: cstring;
                        verbosityLevel: cint; file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_v", importRna.}

proc vrnaEvalStructureSimpleVerbose*(string: cstring; structure: cstring;
                                    file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_simple_verbose", importRna.}

proc vrnaEvalStructureSimpleV*(string: cstring; structure: cstring;
                              verbosityLevel: cint; file: ptr File): cfloat {.cdecl,
    importc: "vrna_eval_structure_simple_v", importRna.}

proc vrnaEvalStructurePt*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort): cint {.cdecl,
    importc: "vrna_eval_structure_pt", importRna.}

proc vrnaEvalStructurePtSimple*(string: cstring; pt: ptr cshort): cint {.cdecl,
    importc: "vrna_eval_structure_pt_simple", importRna.}

proc vrnaEvalStructurePtVerbose*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort;
                                file: ptr File): cint {.cdecl,
    importc: "vrna_eval_structure_pt_verbose", importRna.}

proc vrnaEvalStructurePtV*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort;
                          verbosityLevel: cint; file: ptr File): cint {.cdecl,
    importc: "vrna_eval_structure_pt_v", importRna.}

proc vrnaEvalStructurePtSimpleVerbose*(string: cstring; pt: ptr cshort; file: ptr File): cint {.
    cdecl, importc: "vrna_eval_structure_pt_simple_verbose", importRna.}

proc vrnaEvalStructurePtSimpleV*(string: cstring; pt: ptr cshort;
                                verbosityLevel: cint; file: ptr File): cint {.cdecl,
    importc: "vrna_eval_structure_pt_simple_v", importRna.}

proc vrnaEvalLoopPt*(vc: ptr VrnaFoldCompoundT; i: cint; pt: ptr cshort): cint {.cdecl,
    importc: "vrna_eval_loop_pt", importRna.}

proc vrnaEvalMove*(vc: ptr VrnaFoldCompoundT; structure: cstring; m1: cint; m2: cint): cfloat {.
    cdecl, importc: "vrna_eval_move", importRna.}

proc vrnaEvalMovePt*(vc: ptr VrnaFoldCompoundT; pt: ptr cshort; m1: cint; m2: cint): cint {.
    cdecl, importc: "vrna_eval_move_pt", importRna.}
proc vrnaEvalMovePtSimple*(string: cstring; pt: ptr cshort; m1: cint; m2: cint): cint {.
    cdecl, importc: "vrna_eval_move_pt_simple", importRna.}
