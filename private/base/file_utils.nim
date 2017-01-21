#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaFileCopy*(`from`: ptr File; to: ptr File) {.cdecl, importc: "vrna_file_copy",
    dynlib: rnaLib.}

proc vrnaReadLine*(fp: ptr File): cstring {.cdecl, importc: "vrna_read_line",
                                       dynlib: rnaLib.}

proc vrnaMkdirP*(path: cstring): cint {.cdecl, importc: "vrna_mkdir_p", dynlib: rnaLib.}

proc vrnaBasename*(path: cstring): cstring {.cdecl, importc: "vrna_basename",
    dynlib: rnaLib.}

proc vrnaDirname*(path: cstring): cstring {.cdecl, importc: "vrna_dirname",
                                        dynlib: rnaLib.}
