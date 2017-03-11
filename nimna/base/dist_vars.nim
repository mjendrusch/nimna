#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  editBacktrack* {.importc: "edit_backtrack", dynlib: rnaLib.}: cint
  alignedLine* {.importc: "aligned_line", dynlib: rnaLib.}: array[4, cstring]
  costMatrix* {.importc: "cost_matrix", dynlib: rnaLib.}: cint

type
  PostorderList* = object
    `type`*: cint
    weight*: cint
    father*: cint
    sons*: cint
    leftmostleaf*: cint
  Tree* = object
    postorderList*: ptr PostorderList
    keyroots*: ptr cint
  SwString* = object
    `type`*: cint
    sign*: cint
    weight*: cfloat
