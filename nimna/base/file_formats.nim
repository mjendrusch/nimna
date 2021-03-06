#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_OPTION_MULTILINE* = 32
  VRNA_CONSTRAINT_MULTILINE* = 32

proc vrnaFileHelixlist*(seq: cstring; db: cstring; energy: cfloat; file: ptr File) {.
    cdecl, importc: "vrna_file_helixlist", importRna.}

proc vrnaFileConnect*(seq: cstring; db: cstring; energy: cfloat; identifier: cstring;
                     file: ptr File) {.cdecl, importc: "vrna_file_connect",
                                    importRna.}

proc vrnaFileBpseq*(seq: cstring; db: cstring; file: ptr File) {.cdecl,
    importc: "vrna_file_bpseq", importRna.}

proc vrnaFileFastaReadRecord*(header: cstringArray; sequence: cstringArray;
                             rest: ptr cstringArray; file: ptr File; options: cuint): cuint {.
    cdecl, importc: "vrna_file_fasta_read_record", importRna.}

proc vrnaExtractRecordRestStructure*(lines: cstringArray; length: cuint;
                                    option: cuint): cstring {.cdecl,
    importc: "vrna_extract_record_rest_structure", importRna.}

proc vrnaFileSHAPE_read*(fileName: cstring; length: cint; defaultValue: cdouble;
                        sequence: cstring; values: ptr cdouble): cint {.cdecl,
    importc: "vrna_file_SHAPE_read", importRna.}
