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

proc vrnaAlloc*(size: cuint): pointer {.cdecl, importc: "vrna_alloc", importRna.}

proc vrnaRealloc*(p: pointer; size: cuint): pointer {.cdecl, importc: "vrna_realloc",
    importRna.}

proc vrnaMessageError*(format: cstring) {.varargs, cdecl,
                                       importc: "vrna_message_error",
                                       importRna.}

# proc vrnaMessageVerror*(format: cstring; args: VaList) {.cdecl,
#     importc: "vrna_message_verror", importRna.}

proc vrnaMessageWarning*(format: cstring) {.varargs, cdecl,
    importc: "vrna_message_warning", importRna.}

# proc vrnaMessageVwarning*(format: cstring; args: VaList) {.cdecl,
#     importc: "vrna_message_vwarning", importRna.}

proc vrnaMessageInfo*(fp: ptr File; format: cstring) {.varargs, cdecl,
    importc: "vrna_message_info", importRna.}

# proc vrnaMessageVinfo*(fp: ptr File; format: cstring; args: VaList) {.cdecl,
#     importc: "vrna_message_vinfo", importRna.}

proc vrnaInitRand*() {.cdecl, importc: "vrna_init_rand", importRna.}

var xsubi* {.importc: "xsubi", importRna.}: array[3, cushort]


proc vrnaUrn*(): cdouble {.cdecl, importc: "vrna_urn", importRna.}

proc vrnaIntUrn*(`from`: cint; to: cint): cint {.cdecl, importc: "vrna_int_urn",
    importRna.}

proc vrnaTimeStamp*(): cstring {.cdecl, importc: "vrna_time_stamp", importRna.}

proc getInputLine*(string: cstringArray; options: cuint): cuint {.cdecl,
    importc: "get_input_line", importRna.}

proc vrnaMessageInputSeqSimple*() {.cdecl,
                                  importc: "vrna_message_input_seq_simple",
                                  importRna.}

proc vrnaMessageInputSeq*(s: cstring) {.cdecl, importc: "vrna_message_input_seq",
                                     importRna.}

proc vrnaIdxRowWise*(length: cuint): ptr cint {.cdecl, importc: "vrna_idx_row_wise",
    importRna.}

proc vrnaIdxColWise*(length: cuint): ptr cint {.cdecl, importc: "vrna_idx_col_wise",
    importRna.}
