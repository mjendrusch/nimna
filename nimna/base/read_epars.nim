#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc readParameterFile*(fname: cstring) {.cdecl, importc: "read_parameter_file",
                                       importRna.}
proc writeParameterFile*(fname: cstring) {.cdecl, importc: "write_parameter_file",
                                        importRna.}
proc gettype*(ident: cstring): Parset {.cdecl, importc: "gettype", importRna.}
proc settype*(s: Parset): cstring {.cdecl, importc: "settype", importRna.}
