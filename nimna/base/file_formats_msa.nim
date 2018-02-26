#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_FILE_FORMAT_MSA_CLUSTAL* = 1
  VRNA_FILE_FORMAT_MSA_STOCKHOLM* = 2
  VRNA_FILE_FORMAT_MSA_FASTA* = 4
  VRNA_FILE_FORMAT_MSA_MAF* = 8
  VRNA_FILE_FORMAT_MSA_DEFAULT* = (Vrna_File_Format_Msa_Clustal or
      Vrna_File_Format_Msa_Stockholm or Vrna_File_Format_Msa_Fasta or
      Vrna_File_Format_Msa_Maf)
  VRNA_FILE_FORMAT_MSA_NOCHECK* = 4096
  VRNA_FILE_FORMAT_MSA_UNKNOWN* = 8192

proc vrnaFileMsaRead*(filename: cstring; names: ptr cstringArray;
                     aln: ptr cstringArray; id: ptr cstring;
                     structure: ptr cstring; options: cuint): cint {.cdecl,
    importc: "vrna_file_msa_read", importRna.}

proc vrnaFileMsaReadRecord*(fp: ptr File; names: ptr cstringArray;
                           aln: ptr cstringArray; id: ptr cstring;
                           structure: ptr cstring; options: cuint): cint {.cdecl,
    importc: "vrna_file_msa_read_record", importRna.}

proc vrnaFileMsaDetectFormat*(filename: cstring; options: cuint): cuint {.cdecl,
    importc: "vrna_file_msa_detect_format", importRna.}
