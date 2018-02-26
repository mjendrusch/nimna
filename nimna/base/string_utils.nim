#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  FILENAME_MAX_LENGTH* = 80
  FILENAME_ID_LENGTH* = 42

proc vrnaStrdupPrintf*(format: cstring): cstring {.varargs, cdecl,
    importc: "vrna_strdup_printf", importRna.}

# proc vrnaStrdupVprintf*(format: cstring; argp: VaList): cstring {.cdecl,
#     importc: "vrna_strdup_vprintf", importRna.}

proc vrnaStrcatPrintf*(dest: cstringArray; format: cstring): cint {.varargs, cdecl,
    importc: "vrna_strcat_printf", importRna.}

# proc vrnaStrcatVprintf*(dest: cstringArray; format: cstring; args: VaList): cint {.
#     cdecl, importc: "vrna_strcat_vprintf", importRna.}

proc vrnaRandomString*(l: cint; symbols: ptr char): cstring {.cdecl,
    importc: "vrna_random_string", importRna.}

proc vrnaHammingDistance*(s1: cstring; s2: cstring): cint {.cdecl,
    importc: "vrna_hamming_distance", importRna.}

proc vrnaHammingDistanceBound*(s1: cstring; s2: cstring; n: cint): cint {.cdecl,
    importc: "vrna_hamming_distance_bound", importRna.}

proc vrnaSeqToRNA*(sequence: cstring) {.cdecl, importc: "vrna_seq_toRNA",
                                     importRna.}

proc vrnaSeqToupper*(sequence: cstring) {.cdecl, importc: "vrna_seq_toupper",
                                       importRna.}

proc vrnaCutPointInsert*(string: cstring; cp: cint): cstring {.cdecl,
    importc: "vrna_cut_point_insert", importRna.}

proc vrnaCutPointRemove*(string: cstring; cp: ptr cint): cstring {.cdecl,
    importc: "vrna_cut_point_remove", importRna.}
