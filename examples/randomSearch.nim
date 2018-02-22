#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import nimna
import strutils, math

type SearchError* = object of Exception

proc randomSearch*(len: int, fitness: proc(c: Compound): float,
    maxIter = 500): Compound =
  ## Performs a random search returning the best Compound found with
  ## respect to a user defined fitness function, returning a less-than-zero
  ## value.
  var
    bestFitness = 0.0
  for idx in 0 ..< maxIter:
    let
      current = len.randomDna.compound
      currentFitness = current.fitness
    if currentFitness < bestFitness:
      result = current
      bestFitness = currentFitness

proc randomSearch*(structure: string, maxIter = 500): Compound =
  ## Performs a random search returning the Compound with the lowest free
  ## energy and MFE structure equal to structure. If it cannot find
  ## one, it raises SearchError.
  var
    lowestEnergy = 0.0
  for idx in 0 ..< maxIter:
    let
      current = structure.randomDnaOfStructure.compound
      (energy, currentStructure) = current.mfe
    if structure == currentStructure and energy < lowestEnergy:
      result = current
      lowestEnergy = energy
  if lowestEnergy == 0.0:
    raise newException(SearchError,
      "No suitable sequence found for structure $#!" % [structure])

proc main =
  ## Find a Compound of length 10 with GC-content close to 50%:
  let gc50 = randomSearch(10, proc(c: Compound): float =
    result = 0.0
    for elem in c.sequence:
      case elem
      of 'G', 'g', 'C', 'c':
        result += 1.0
      else:
        discard
      result = pow(result / c.len.float - 0.5, 2) - 1.0
  )

  ## Find a Hairpin.
  var hairpin: Compound
  try:
    hairpin = randomSearch("((((((((...))))))))")
  except SearchError:
    hairpin = compound"GGGGGGGAAACCCCCCC"
  echo "GC 50% : $#".format(gc50.sequence)
  echo "Hairpin : $#".format(hairpin.sequence)

when isMainModule:
  main()
