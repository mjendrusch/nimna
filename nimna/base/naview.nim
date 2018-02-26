#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc naviewXyCoordinates*(pairTable: ptr cshort; x: ptr cfloat; y: ptr cfloat): cint {.
    cdecl, importc: "naview_xy_coordinates", importRna.}
