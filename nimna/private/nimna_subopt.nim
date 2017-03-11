#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc freeSuboptimals(so: Suboptimals) =
  free(so.so)

proc suboptimals*(c: Compound, delta: int = 10, sorted: bool = true): Suboptimals =
  ## Generates suboptimal folds of the Compound, with distance of
  ## delta * 0.01 kcal / mol from the optimum. If sorted is set to true,
  ## those are sorted by ascending free energy.
  new result, freeSuboptimals
  withRef c:
    if c.vfc[].params[].modelDetails.uniqML != 1:
      c.vfc[].params[].modelDetails.uniqML = 1
      c.update(c.vfc[].params[].modelDetails.Settings)
    result.so = vrnaSubopt(c.vfc, delta.cint, cast[cint](sorted), cast[File](nil))
  var
    length = 0
    current = result.so
  while not current[].structure.isNil():
    inc length
  result.len = length

template E*(f: Fold): float =
  f.energy.float

template struc*(f: Fold): string =
  $f.structure

proc `[]`*(so: Suboptimals, idx: int): tuple[E: float, struc: string] =
  ## Bracket accessor for Suboptimals.
  if idx >= so.len:
    raise newException(IndexError,
      "idx may not be greater than or equal to the length of the Suboptimals.")
  (E: so.so[idx].E, struc: so.so[idx].struc)

iterator items*(so: Suboptimals): tuple[E: float, struc: string] =
  ## Iterates over items in a set of Suboptimals, including their energy
  ## and structure.
  for idx in 0 ..< so.len:
    yield (E: so[idx].E, struc: so[idx].struc)

iterator pairs*(so: Suboptimals): tuple[key: int, val: tuple[E: float, struc: string]] =
  ## Iterates over itens in a set of Suboptimals, as well as their position in
  ## the set.
  for idx in 0 ..< so.len:
    yield (key: idx, val: (E: so[idx].E, struc: so[idx].struc))
