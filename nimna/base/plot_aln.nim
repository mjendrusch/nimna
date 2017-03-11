#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc psColorAln*(structure: cstring; filename: cstring; seqs: ptr cstring;
                 names: ptr cstring): cint {.cdecl, importc: "PS_color_aln",
    dynlib: rnaLib.}

proc aliPsColorAln*(structure: cstring; filename: cstring; seqs: ptr cstring;
                    names: ptr cstring): cint {.cdecl, importc: "aliPS_color_aln",
    dynlib: rnaLib.}
