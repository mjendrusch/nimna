#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaSequenceLengthMax*(options: cuint): cuint {.cdecl,
    importc: "vrna_sequence_length_max", importRna.}
proc vrnaNucleotideIUPAC_identity*(a: char; b: char): cint {.cdecl,
    importc: "vrna_nucleotide_IUPAC_identity", importRna.}
proc vrnaPtypes*(s: ptr cshort; md: ptr VrnaMdT): cstring {.cdecl,
    importc: "vrna_ptypes", importRna.}
proc vrnaSeqEncode*(sequence: cstring; md: ptr VrnaMdT): ptr cshort {.cdecl,
    importc: "vrna_seq_encode", importRna.}
proc vrnaSeqEncodeSimple*(sequence: cstring; md: ptr VrnaMdT): ptr cshort {.cdecl,
    importc: "vrna_seq_encode_simple", importRna.}
proc vrnaNucleotideEncode*(c: char; md: ptr VrnaMdT): cint {.cdecl,
    importc: "vrna_nucleotide_encode", importRna.}
proc vrnaNucleotideDecode*(enc: cint; md: ptr VrnaMdT): char {.cdecl,
    importc: "vrna_nucleotide_decode", importRna.}
proc vrnaAlnEncode*(sequence: cstring; s_p: ptr ptr cshort; s5P: ptr ptr cshort;
                   s3P: ptr ptr cshort; ssP: cstringArray; asP: ptr ptr cushort;
                   md: ptr VrnaMdT) {.cdecl, importc: "vrna_aln_encode",
                                   importRna.}
