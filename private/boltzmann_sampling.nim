#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaPbacktrack5*(vc: ptr VrnaFoldCompoundT; length: cint): cstring {.cdecl,
    importc: "vrna_pbacktrack5", dynlib: rnaLib.}
proc vrnaPbacktrack*(vc: ptr VrnaFoldCompoundT): cstring {.cdecl,
    importc: "vrna_pbacktrack", dynlib: rnaLib.}
