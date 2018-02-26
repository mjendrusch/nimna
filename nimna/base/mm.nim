#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc maximumMatching*(str: cstring): cuint {.cdecl, importc: "maximumMatching",
    importRna.}
proc maximumMatchingConstraint*(str: cstring; ptable: ptr cshort): ptr cuint {.cdecl,
    importc: "maximumMatchingConstraint", importRna.}
proc maximumMatching2Constraint*(str: cstring; ptable: ptr cshort;
                                ptable2: ptr cshort): ptr cuint {.cdecl,
    importc: "maximumMatching2Constraint", importRna.}
