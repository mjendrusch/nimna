#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc maximumMatching*(string: cstring): cuint {.cdecl, importc: "maximumMatching",
    dynlib: rnaLib.}
proc maximumMatchingConstraint*(string: cstring; ptable: ptr cshort): ptr cuint {.cdecl,
    importc: "maximumMatchingConstraint", dynlib: rnaLib.}
proc maximumMatching2Constraint*(string: cstring; ptable: ptr cshort;
                                ptable2: ptr cshort): ptr cuint {.cdecl,
    importc: "maximumMatching2Constraint", dynlib: rnaLib.}
