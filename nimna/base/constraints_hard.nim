#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_CONSTRAINT_NO_HEADER* = 0
  VRNA_CONSTRAINT_DB* = 16384
  VRNA_CONSTRAINT_DB_ENFORCE_BP* = 32768
  VRNA_CONSTRAINT_DB_PIPE* = 65536
  VRNA_CONSTRAINT_DB_DOT* = 131072
  VRNA_CONSTRAINT_DB_X* = 262144
  VRNA_CONSTRAINT_DB_ANG_BRACK* = 524288
  VRNA_CONSTRAINT_DB_RND_BRACK* = 1048576
  VRNA_CONSTRAINT_DB_INTRAMOL* = 2097152
  VRNA_CONSTRAINT_DB_INTERMOL* = 4194304
  VRNA_CONSTRAINT_DB_GQUAD* = 8388608
  VRNA_CONSTRAINT_DB_DEFAULT* = (Vrna_Constraint_Db or Vrna_Constraint_Db_Pipe or
      Vrna_Constraint_Db_Dot or Vrna_Constraint_Db_X or
      Vrna_Constraint_Db_Ang_Brack or Vrna_Constraint_Db_Rnd_Brack or
      Vrna_Constraint_Db_Intramol or Vrna_Constraint_Db_Intermol or
      Vrna_Constraint_Db_Gquad)
  VRNA_CONSTRAINT_CONTEXT_EXT_LOOP* = char(0x00000001)
  VRNA_CONSTRAINT_CONTEXT_HP_LOOP* = char(0x00000002)
  VRNA_CONSTRAINT_CONTEXT_INT_LOOP* = char(0x00000004)
  VRNA_CONSTRAINT_CONTEXT_INT_LOOP_ENC* = char(0x00000008)
  VRNA_CONSTRAINT_CONTEXT_MB_LOOP* = char(0x00000010)
  VRNA_CONSTRAINT_CONTEXT_MB_LOOP_ENC* = char(0x00000020)
  VRNA_CONSTRAINT_CONTEXT_ENFORCE* = char(0x00000040)
  VRNA_CONSTRAINT_CONTEXT_NO_REMOVE* = char(0x00000080)
  VRNA_CONSTRAINT_CONTEXT_ALL_LOOPS* = char(uint(Vrna_Constraint_Context_Ext_Loop) or
      uint(Vrna_Constraint_Context_Hp_Loop) or uint(Vrna_Constraint_Context_Int_Loop) or
      uint(Vrna_Constraint_Context_Int_Loop_Enc) or uint(Vrna_Constraint_Context_Mb_Loop) or
      uint(Vrna_Constraint_Context_Mb_Loop_Enc))

proc vrnaMessageConstraintOptions*(option: cuint) {.cdecl,
    importc: "vrna_message_constraint_options", dynlib: rnaLib.}

proc vrnaMessageConstraintOptionsAll*() {.cdecl, importc: "vrna_message_constraint_options_all",
                                        dynlib: rnaLib.}

proc vrnaHcInit*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_hc_init",
    dynlib: rnaLib.}

proc vrnaHcAddUp*(vc: ptr VrnaFoldCompoundT; i: cint; option: char) {.cdecl,
    importc: "vrna_hc_add_up", dynlib: rnaLib.}

proc vrnaHcAddUpBatch*(vc: ptr VrnaFoldCompoundT; constraints: ptr VrnaHcUpT): cint {.
    cdecl, importc: "vrna_hc_add_up_batch", dynlib: rnaLib.}

proc vrnaHcAddBp*(vc: ptr VrnaFoldCompoundT; i: cint; j: cint; option: char) {.cdecl,
    importc: "vrna_hc_add_bp", dynlib: rnaLib.}

proc vrnaHcAddBpNonspecific*(vc: ptr VrnaFoldCompoundT; i: cint; d: cint; option: char) {.
    cdecl, importc: "vrna_hc_add_bp_nonspecific", dynlib: rnaLib.}

proc vrnaHcFree*(hc: ptr VrnaHcT) {.cdecl, importc: "vrna_hc_free", dynlib: rnaLib.}
when defined(WITH_GEN_HC):
  proc vrnaHcAddF*(vc: ptr VrnaFoldCompoundT; f: ptr VrnaCallbackHcEvaluate) {.cdecl,
      importc: "vrna_hc_add_f", dynlib: rnaLib.}
  proc vrnaHcAddData*(vc: ptr VrnaFoldCompoundT; data: pointer;
                     f: ptr VrnaCallbackFreeAuxdata) {.cdecl,
      importc: "vrna_hc_add_data", dynlib: rnaLib.}

proc vrnaHcAddFromDb*(vc: ptr VrnaFoldCompoundT; constraint: cstring; options: cuint): cint {.
    cdecl, importc: "vrna_hc_add_from_db", dynlib: rnaLib.}
