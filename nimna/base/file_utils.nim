#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaFileCopy*(`from`: ptr File; to: ptr File) {.cdecl, importc: "vrna_file_copy",
    importRna.}

proc vrnaReadLine*(fp: ptr File): cstring {.cdecl, importc: "vrna_read_line",
                                       importRna.}

proc vrnaMkdirP*(path: cstring): cint {.cdecl, importc: "vrna_mkdir_p", importRna.}

proc vrnaBasename*(path: cstring): cstring {.cdecl, importc: "vrna_basename",
    importRna.}

proc vrnaDirname*(path: cstring): cstring {.cdecl, importc: "vrna_dirname",
                                        importRna.}
