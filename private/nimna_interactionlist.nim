#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc freePairList(pl: PairList) =
  free(pl.pl)
template newPairList(pl: untyped): untyped =
  new pl, freePairList

template `[]`*(pl: PairList, idx: int): PairListItem =
  ## Bracket accessot for the PairList.
  pl.pl[idx]

proc pairList*(structure: string, probability: float): PairList =
  ## Creates a PairList from a dot-bracket secondary structure string
  ## together with a weighting probability.
  result.newPairList
  result.len = structure.len
  result.pl = vrnaPList(structure.cstring, probability.cfloat)

proc pairList*(c: Compound, cutoff: float = 1E-6): PairList =
  ## Creates a PairList from a Compound, taking into account all base pairs
  ## with probability greater than a cutoff. If no probabilities exist, they
  ## will be computed.
  c.recomputePfImpl
  result.newPairList
  result.len = c.len
  result.pl = vrnaPlistFromProbs(c.vfc, cutoff.cdouble)

proc pairList*(p: Probabilities, cutoff: float = 1E-6): PairList =
  ## Creates a PairList from a set of Probabilities, taking into account all
  ## base pairs with probability greater than cutoff.
  result.newPairList
  result.len = p.parent.len
  result.pl = vrnaPlistFromProbs(p.parent.vfc, cutoff.cdouble)

iterator items*(pl: PairList): PairListItem =
  ## Iterates over PairListItems in a PairList.
  for idx in 0 ..< pl.len:
    yield pl[idx]

iterator probabilities*(pl: PairList): float =
  ## Iterates over probabilities in a PairList.
  for val in pl.items:
    yield val.p.float

iterator basePairs*(pl: PairList): tuple[i, j: int] =
  ## Iterates over base pairs contained in a PairList.
  for val in pl.items:
    yield (i: val.i.int, j: val.j.int)

iterator pairs*(pl: PairList): tuple[bp: tuple[i, j: int], prob: float] =
  ## Iterates over pairs of base pairs and probabilities.
  for val in pl.items:
    yield (bp: (i: val.i.int, j: val.j.int), prob: val.p.float)

iterator triples*(pl: PairList): tuple[i, j: int, prob: float] =
  ## Iterates over triples of base positions i, j and their pairing
  ## probabilities.
  for val in pl.items:
    yield (i: val.i.int, j: val.j.int, prob: val.p.float)
