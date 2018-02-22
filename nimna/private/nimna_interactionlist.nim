#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import RNA
import nimna_types, nimna_cutils, nimna_compound, nimna_fold

proc freePairList(pl: PairList) =
  free(pl.pl)
template newPairList(pl: untyped): untyped =
  new pl, freePairList

template `[]`*(pl: PairList, idx: int): PairListItem =
  ## Bracket accessor for the PairList.
  pl.pl[idx]

proc pairList*(structure: string, probability: float): PairList =
  ## Creates a PairList from a dot-bracket secondary structure string
  ## together with a weighting probability.
  result.newPairList
  result.len = structure.len
  result.nitems = structure.len
  result.pl = vrnaPList(structure.cstring, probability.cfloat)

proc pairList*(c: Compound, cutoff: float = 1E-6): PairList =
  ## Creates a PairList from a Compound, taking into account all base pairs
  ## with probability greater than a cutoff. If no probabilities exist, they
  ## will be computed.
  c.recomputePfImpl
  result.newPairList
  result.pl = vrnaPlistFromProbs(c.vfc, cutoff.cdouble)
  var
    count = 0
  while result.pl[count].i != 0 and result.pl[count].j != 0:
    inc count
  result.len = c.len
  result.nitems = count

proc pairList*(p: Probabilities, cutoff: float = 1E-6): PairList =
  ## Creates a PairList from a set of Probabilities, taking into account all
  ## base pairs with probability greater than cutoff.
  result.newPairList
  result.pl = vrnaPlistFromProbs(p.parent.vfc, cutoff.cdouble)
  var
    count = 0
  while result.pl[count].i != 0 and result.pl[count].j != 0:
    inc count
  result.len = p.parent.len
  result.nitems = count

# Maximum expected accuracy folding

proc mea*(pl: PairList, gamma: float = 1.0'f64):
    tuple[accuracy: float; struc: string] =
  ## Computes the maximum accuracy structure of an Ensemble stored in a PairList.
  var struc = cast[cstring](alloc0((pl.len + 1) * sizeOf(char)))
  for idx in 0 ..< pl.len:
    struc[idx] = '.'
  defer: dealloc struc
  withRef pl:
    result.accuracy = mea(pl.pl, struc, gamma.cdouble)
    result.struc = $struc

proc mea*(c: Compound, gamma: float = 1.0'f64):
    tuple[accuracy: float; struc: string] =
  ## Computes the maximum accuracy structure of an Ensemble stored in a Compound.
  ## A computation of the partition function will be done, if no ensemble is
  ## available.
  c.recomputePfImpl
  result = c.pairList.mea(gamma)

proc mea*(p: Probabilities, gamma: float = 1.0'f64):
    tuple[accuracy: float; struc: string] =
  ## Computes the maximum accuracy structure of an Ensemble stored in
  ## a set of Probabilities.
  result = p.pairList.mea(gamma)


iterator items*(pl: PairList): PairListItem =
  ## Iterates over PairListItems in a PairList.
  for idx in 0 ..< pl.nitems:
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
