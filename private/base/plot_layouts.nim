#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_PLOT_TYPE_SIMPLE* = 0
  VRNA_PLOT_TYPE_NAVIEW* = 1
  VRNA_PLOT_TYPE_CIRCULAR* = 2

type
  Coordinate* = object
    x*: cfloat
    y*: cfloat

var rnaPlotType* {.importc: "rna_plot_type", dynlib: rnaLib.}: cint

proc simpleXyCoordinates*(pairTable: ptr cshort; x: ptr cfloat; y: ptr cfloat): cint {.
    cdecl, importc: "simple_xy_coordinates", dynlib: rnaLib.}

proc simpleCircplotCoordinates*(pairTable: ptr cshort; x: ptr cfloat; y: ptr cfloat): cint {.
    cdecl, importc: "simple_circplot_coordinates", dynlib: rnaLib.}
