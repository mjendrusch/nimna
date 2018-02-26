#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaAlifold*(sequences: cstringArray; structure: cstring): cfloat {.cdecl,
    importc: "vrna_alifold", importRna.}

proc vrnaCircalifold*(sequences: cstringArray; structure: cstring): cfloat {.cdecl,
    importc: "vrna_circalifold", importRna.}

proc vrnaPfAlifold*(sequences: cstringArray; structure: cstring;
                   pl: ptr ptr VrnaPlistT): cfloat {.cdecl,
    importc: "vrna_pf_alifold", importRna.}

proc vrnaPfCircalifold*(sequences: cstringArray; structure: cstring;
                       pl: ptr ptr VrnaPlistT): cfloat {.cdecl,
    importc: "vrna_pf_circalifold", importRna.}
