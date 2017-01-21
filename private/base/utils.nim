#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_INPUT_ERROR* = 1
  VRNA_INPUT_QUIT* = 2
  VRNA_INPUT_MISC* = 4
  VRNA_INPUT_FASTA_HEADER* = 8
  VRNA_INPUT_SEQUENCE* = 16
  VRNA_INPUT_CONSTRAINT* = 32
  VRNA_INPUT_NO_TRUNCATION* = 256
  VRNA_INPUT_NO_REST* = 512
  VRNA_INPUT_NO_SPAN* = 1024
  VRNA_INPUT_NOSKIP_BLANK_LINES* = 2048
  VRNA_INPUT_BLANK_LINE* = 4096
  VRNA_INPUT_NOSKIP_COMMENTS* = 128
  VRNA_INPUT_COMMENT* = 8192

proc vrnaAlloc*(size: cuint): pointer {.cdecl, importc: "vrna_alloc", dynlib: rnaLib.}

proc vrnaRealloc*(p: pointer; size: cuint): pointer {.cdecl, importc: "vrna_realloc",
    dynlib: rnaLib.}

proc vrnaMessageError*(format: cstring) {.varargs, cdecl,
                                       importc: "vrna_message_error",
                                       dynlib: rnaLib.}

proc vrnaMessageVerror*(format: cstring; args: VaList) {.cdecl,
    importc: "vrna_message_verror", dynlib: rnaLib.}

proc vrnaMessageWarning*(format: cstring) {.varargs, cdecl,
    importc: "vrna_message_warning", dynlib: rnaLib.}

proc vrnaMessageVwarning*(format: cstring; args: VaList) {.cdecl,
    importc: "vrna_message_vwarning", dynlib: rnaLib.}

proc vrnaMessageInfo*(fp: ptr File; format: cstring) {.varargs, cdecl,
    importc: "vrna_message_info", dynlib: rnaLib.}

proc vrnaMessageVinfo*(fp: ptr File; format: cstring; args: VaList) {.cdecl,
    importc: "vrna_message_vinfo", dynlib: rnaLib.}

proc vrnaInitRand*() {.cdecl, importc: "vrna_init_rand", dynlib: rnaLib.}

var xsubi* {.importc: "xsubi", dynlib: rnaLib.}: array[3, cushort]


proc vrnaUrn*(): cdouble {.cdecl, importc: "vrna_urn", dynlib: rnaLib.}

proc vrnaIntUrn*(`from`: cint; to: cint): cint {.cdecl, importc: "vrna_int_urn",
    dynlib: rnaLib.}

proc vrnaTimeStamp*(): cstring {.cdecl, importc: "vrna_time_stamp", dynlib: rnaLib.}

proc getInputLine*(string: cstringArray; options: cuint): cuint {.cdecl,
    importc: "get_input_line", dynlib: rnaLib.}

proc vrnaMessageInputSeqSimple*() {.cdecl,
                                  importc: "vrna_message_input_seq_simple",
                                  dynlib: rnaLib.}

proc vrnaMessageInputSeq*(s: cstring) {.cdecl, importc: "vrna_message_input_seq",
                                     dynlib: rnaLib.}

proc vrnaIdxRowWise*(length: cuint): ptr cint {.cdecl, importc: "vrna_idx_row_wise",
    dynlib: rnaLib.}

proc vrnaIdxColWise*(length: cuint): ptr cint {.cdecl, importc: "vrna_idx_col_wise",
    dynlib: rnaLib.}
