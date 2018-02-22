#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import RNA
import nimna_types, nimna_cutils

proc freeMfeSolutions*(s: MfeSolutions) =
  free(s.mfe)
proc freePfSolutions*(s: PfSolutions) =
  free(s.pf)

template makeIterators(name, lc, pairType: untyped): untyped =
  const solutionTerminator = 10000000
  iterator items*(s: `name Solutions`): `name Solution` =
    ## Iterate over Solution obects in a set of Solutions.
    var idx = 0
    while s.`lc`[idx].kappa.int != solutionTerminator:
      yield s.`lc`[idx]
  iterator pairs*(s: `name Solutions`):
      tuple[pos: tuple[kappa: int, lambda: int], val: pairType] =
    ## Iterate over pairs of distances (kappa, lambda) and Solution
    ## values.
    var idx = 0
    while s.`lc`[idx].kappa.int != solutionTerminator:
      let sol = s.`lc`[idx]
      when pairType is float:
        yield (pos: (kappa: sol.kappa.int, lambda: sol.lambda.int),
          val: sol.partitionFunction.float)
      else:
        yield (pos: (kappa: sol.kappa.int, lambda: sol.lambda.int),
          val: (E: sol.energy.float, struc: $sol.structure))
  iterator triples*(s: `name Solutions`):
      tuple[kappa: int, lambda: int, val: pairType] =
    ## Iterate over triples of kappa, lambda, values.
    var idx = 0
    while s.`lc`[idx].kappa.int != solutionTerminator:
      let sol = s.`lc`[idx]
      when pairType is float:
        yield (kappa: sol.kappa.int, lambda: sol.lambda.int,
          val: sol.partitionFunction.float)
      else:
        yield (kappa: sol.kappa.int, lambda: sol.lambda.int,
          val: (E: sol.energy.float, struc: $sol.structure))

makeIterators(Mfe, mfe, tuple[E: float, struc: string])
makeIterators(Pf, pf, float)
