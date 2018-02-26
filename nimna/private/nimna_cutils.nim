#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

## .. include:: ../../docs/cutils.txt

proc free*(p: pointer) {. importc: "free", nodecl .}
proc calloc*(num, size: cuint): pointer {. importc: "calloc", nodecl .}
template withRef*(x, y: untyped) =
  GcRef(x)
  y
  GcUnref(x)
template `+`*[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))
template `[]`*[T](p: ptr T, off: int): T =
  (p + off)[]
