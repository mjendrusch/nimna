#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

## .. include:: ../../docs/sample.txt

import RNA
import nimna_types, nimna_cutils, nimna_compound, nimna_fold

proc sample*(c: Compound): string =
  ## Samples a secondary structure from an ensemble according to its probability.
  c.recomputePfImpl
  withRef c:
    let structure = vrnaPBacktrack(c.vfc)
    result = $structure
  dealloc structure

proc sample2D*(c: Compound2D; distance1, distance2: int): string =
  ## Samples a secondary structure at a position in secondary structure
  ## space with distance1 from one reference structure and distance2 from
  ## the other.
  c.recomputePfImpl
  withRef c:
    let structure = vrnaPBacktrackTwoD(c.vfc, distance1.cint, distance2.cint)
    result = $structure
  dealloc structure
