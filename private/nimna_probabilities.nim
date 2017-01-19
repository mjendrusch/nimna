#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc pf*(c: Compound): tuple[E: float; struc: string]
proc pfDimer*(c: Compound): tuple[E: DimerEnergies; struc: string]
template len*(p: Probabilities): int =
  p.parent.len

proc `[]`*(p: Probabilities; i, j: int): float =
  if i + 1 > p.parent.length.int or j + 1 > p.parent.length.int:
    raise newException(IndexError, "index out of bounds!")
  elif i < j:
    result = p.bppm[p.parent.iindx[i + 1] - (j + 1)]
  else:
    result = p.bppm[p.parent.iindx[j + 1] - (i + 1)]

proc probabilities*(c: Compound): Probabilities =
  ## Returns a Probabilities object for monitoring the base pair probabilities
  ## inside the Compound. If no probabilities exist, they will be computed.
  c.recomputePfImpl
  new result
  let partFunc = c.expMatrices
  if partFunc[].typ == VrnaMxDefault:
    result.bppm = partFunc[].union.default.probs
    result.parent = c
  else:
    raise newException(FieldError,
      "Compound does not contain the field `probs`")

proc prob*(c: Compound; i, j: int): float =
  ## Returns the probability of base-pairing at positions i and j in a Compound.
  c.probabilities[i, j]

iterator items*(p: Probabilities): float =
  ## Iterates over all entries in the probability matrix.
  for idx in 0 ..< p.parent.length.int:
    for idy in 0 ..< p.parent.length.int:
      yield p[idx, idy]

iterator pairs*(p: Probabilities): tuple[pos: tuple[i, j: int], val: float] =
  ## Iterates over all pairs of indices (i, j) and their corresponding
  ## base pairing probabilities val.
  for idx in 0 ..< p.parent.length.int:
    for idy in 0 ..< p.parent.length.int:
      yield (pos: (i: idx, j: idy), val: p[idx, idy])

iterator triples*(p: Probabilities): tuple[i, j: int, val: float] =
  ## Iterates over all triples of indices i, j and their corresponding
  ## base pairing probabilities val.
  for idx in 0 ..< p.parent.length.int:
    for idy in 0 ..< p.parent.length.int:
      yield (i: idx, j: idy, val: p[idx, idy])

iterator positions*(p: Probabilities): seq[float] =
  ## Iterates over all positions in the sequence corresponding
  ## to the Probabilities, returning a seq of their base pairing
  ## probabilities.
  for idx in 0 ..< p.parent.length.int:
    var sq = newSeq[float](p.parent.length.int)
    for idy in 0 ..< p.parent.length.int:
      sq[idy] = p[idx, idy]
