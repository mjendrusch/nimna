#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import RNA
import nimna_types, nimna_cutils, nimna_compound, nimna_2dfold

template foldImpl(c, name: untyped): untyped =
  let
    sq = cast[cstring](c.sequence)
    structure = cast[ptr char](alloc0((sq.len + 1) * sizeOf(char)))
  defer: dealloc structure
  withRef c:
    result.E = name(c.vfc, structure)
  result.struc = $structure

template fold2DImpl(c, name: untyped): untyped =
  new result, `free name Solutions`
  withRef c:
    result.name = `vrna name TwoD`(c.vfc, distance1.cint, distance2.cint)

proc pf*(c: Compound): tuple[E: float; struc: string] =
  ## Partition function folding for a Compound.
  ## Returns a tuple of ensemble energy and secondary structure.
  foldImpl(c, pf)
  c.hasPf = true

proc mfe*(c: Compound): tuple[E: float; struc: string] =
  ## Minimum free energy folding for a Compound.
  ## Returns a tuple of MFE and secondary structure.
  foldImpl(c, mfe)

proc mfeWindow*(c: Compound, f: File): float =
  ## Computes the structure of a compound using a sliding
  ## window. The structure is written to a File on the fly.
  withRef c:
    result = mfeWindow(c.vfc, f)


proc pf2D*(c: Compound2D; distance1, distance2: int): PfSolutions =
  ## Computes the partition function at all points in secondary
  ## structure space with maximum distance1 to one reference
  ## structure and maximum distance2 to another.
  fold2DImpl(c, pf)
  c.hasPf = true

proc mfe2D*(c: Compound2D; distance1, distance2: int): MfeSolutions =
  ## Computes the Mfe structure, as well as its free energy at
  ## all points in secondary structure space with maximum distance1
  ## to one reference structure and maximum distance2 to another.
  fold2DImpl(c, mfe)

proc pfDimer*(c: Compound): tuple[E: DimerEnergies; struc: string] =
  ## Partition function folding for a Compound (dimer).
  ## Returns a tuple of ensemble energy and secondary structure.
  foldImpl(c, pfDimer)
  c.hasPf = true

proc mfeDimer*(c: Compound): tuple[E: float; struc: string] =
  ## Minimum free energy folding for a Compound (dimer).
  ## Returns a tuple of MFE and secondary structure.
  foldImpl(c, mfeDimer)

# Centroid folding

template centroidImpl(x, sqAcc, call: untyped): untyped =
  let sq = cast[cstring](sqAcc)
  withRef x:
    let structure = call
    result.struc = $structure
  dealloc structure

proc centroid*(c: Compound): tuple[dist: float; struc: string] =
  ## Computes the centroid structure of an ensemble stored in a Compound,
  ## returning a tuple of the mean distance from that structure in the
  ## ensemble and the centroid structure itself.
  ## A computation of the partition function will be done, if no base pairing
  ## probabilities exist.
  c.recomputePfImpl
  centroidImpl(c, c.sequence, vrnaCentroid(c.vfc, result.dist.unsafeAddr))

proc centroid*(p: Probabilities): tuple[dist: float; struc: string] =
  ## Computes the centroid structure of an ensemble stored in a Probabilities
  ## object.
  centroidImpl(p, p.parent.sequence,
    vrnaCentroidFromProbs(p.parent.length.cint, result.dist.unsafeAddr, p.bppm))
