#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc mxAdd*(vc: ptr VrnaFoldCompoundT; `type`: MxTypeE; options: cuint): cint {.cdecl,
    importc: "vrna_mx_add", importRna.}
proc mxMfeAdd*(vc: ptr VrnaFoldCompoundT; mxType: MxTypeE; options: cuint): cint {.cdecl,
    importc: "vrna_mx_mfe_add", importRna.}
proc mxPfAdd*(vc: ptr VrnaFoldCompoundT; mxType: MxTypeE; options: cuint): cint {.cdecl,
    importc: "vrna_mx_pf_add", importRna.}
proc mxPrepare*(vc: ptr VrnaFoldCompoundT; options: cuint): cint {.cdecl,
    importc: "vrna_mx_prepare", importRna.}

proc mxMfeFree*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_mx_mfe_free",
                                     importRna.}

proc mxPfFree*(vc: ptr VrnaFoldCompoundT) {.cdecl, importc: "vrna_mx_pf_free",
                                    importRna.}
