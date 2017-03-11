#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc readClustal*(clust: ptr File; alignedSeqs: ptr cstring; names: ptr cstring): cint {.
    cdecl, importc: "read_clustal", dynlib: rnaLib.}
proc consensus*(`as`: ptr cstring): cstring {.cdecl, importc: "consensus",
    dynlib: rnaLib.}
proc consensMis*(`as`: ptr cstring): cstring {.cdecl, importc: "consens_mis",
    dynlib: rnaLib.}
proc getUngappedSequence*(seq: cstring): cstring {.cdecl,
    importc: "get_ungapped_sequence", dynlib: rnaLib.}

proc vrnaAlnMpi*(alignment: cstringArray): cint {.cdecl, importc: "vrna_aln_mpi",
    dynlib: rnaLib.}

proc vrnaAlnPinfo*(vc: ptr VrnaFoldCompoundT; structure: cstring; threshold: cdouble): ptr VrnaPinfoT {.
    cdecl, importc: "vrna_aln_pinfo", dynlib: rnaLib.}
proc vrnaAlnPscore*(alignment: cstringArray; md: ptr VrnaMdT): ptr cint {.cdecl,
    importc: "vrna_aln_pscore", dynlib: rnaLib.}

proc encodeAliSequence*(sequence: cstring; s: ptr cshort; s5: ptr cshort; s3: ptr cshort;
                       ss: cstring; `as`: ptr cushort; circ: cint) {.cdecl,
    importc: "encode_ali_sequence", dynlib: rnaLib.}

proc allocSequenceArrays*(sequences: cstringArray; s: ptr ptr ptr cshort;
                         s5: ptr ptr ptr cshort; s3: ptr ptr ptr cshort;
                         a2s: ptr ptr ptr cushort; ss: ptr cstringArray; circ: cint) {.
    cdecl, importc: "alloc_sequence_arrays", dynlib: rnaLib.}

proc freeSequenceArrays*(nSeq: cuint; s: ptr ptr ptr cshort; s5: ptr ptr ptr cshort;
                        s3: ptr ptr ptr cshort; a2s: ptr ptr ptr cushort;
                        ss: ptr cstringArray) {.cdecl,
    importc: "free_sequence_arrays", dynlib: rnaLib.}
