#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



proc vrnaConstraintsAddSHAPE*(vc: ptr VrnaFoldCompoundT; shapeFile: cstring;
                             shapeMethod: cstring; shapeConversion: cstring;
                             verbose: cint; constraintType: cuint) {.cdecl,
    importc: "vrna_constraints_add_SHAPE", dynlib: rnaLib.}
proc vrnaConstraintsAddSHAPE_ali*(vc: ptr VrnaFoldCompoundT; shapeMethod: cstring;
                                 shapeFiles: cstringArray;
                                 shapeFileAssociation: ptr cint; verbose: cint;
                                 constraintType: cuint) {.cdecl,
    importc: "vrna_constraints_add_SHAPE_ali", dynlib: rnaLib.}

proc vrnaScAddSHAPE_deigan*(vc: ptr VrnaFoldCompoundT; reactivities: ptr cdouble;
                           m: cdouble; b: cdouble; options: cuint): cint {.cdecl,
    importc: "vrna_sc_add_SHAPE_deigan", dynlib: rnaLib.}

proc vrnaScAddSHAPE_deiganAli*(vc: ptr VrnaFoldCompoundT; shapeFiles: cstringArray;
                              shapeFileAssociation: ptr cint; m: cdouble; b: cdouble;
                              options: cuint): cint {.cdecl,
    importc: "vrna_sc_add_SHAPE_deigan_ali", dynlib: rnaLib.}

proc vrnaScAddSHAPE_zarringhalam*(vc: ptr VrnaFoldCompoundT;
                                 reactivities: ptr cdouble; b: cdouble;
                                 defaultValue: cdouble; shapeConversion: cstring;
                                 options: cuint): cint {.cdecl,
    importc: "vrna_sc_add_SHAPE_zarringhalam", dynlib: rnaLib.}

proc vrnaScSHAPE_parseMethod*(methodString: cstring; `method`: cstring;
                             param1: ptr cfloat; param2: ptr cfloat): cint {.cdecl,
    importc: "vrna_sc_SHAPE_parse_method", dynlib: rnaLib.}

proc vrnaScSHAPE_toPr*(shapeConversion: cstring; values: ptr cdouble; length: cint;
                      defaultValue: cdouble): cint {.cdecl,
    importc: "vrna_sc_SHAPE_to_pr", dynlib: rnaLib.}