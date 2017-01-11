#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



type
  Parset* {.size: sizeof(cint).} = enum
    UNKNOWN = - 1, QUIT, S, S_H, HP, HP_H, B, B_H, IL, IL_H, MMH, MMH_H, MMI, MMI_H, MMI1N,
    MMI1N_H, MMI23, MMI23_H, MMM, MMM_H, MME, MME_H, D5, D5_H, D3, D3_H, INT11, INT11_H,
    INT21, INT21_H, INT22, INT22_H, ML, TL, TRI, HEX, NIN, MISC



proc readParameterFile*(fname: ptr char) {.cdecl, importc: "read_parameter_file",
                                       dynlib: rnaLib.}

proc writeParameterFile*(fname: ptr char) {.cdecl, importc: "write_parameter_file",
                                        dynlib: rnaLib.}

proc gettype*(ident: cstring): Parset {.cdecl, importc: "gettype", dynlib: rnaLib.}

proc settype*(s: Parset): cstring {.cdecl, importc: "settype", dynlib: rnaLib.}
