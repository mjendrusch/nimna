#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

## .. include:: ../docs/design.txt

import nimna
import tables, random, algorithm, sequtils, sets

const
  concreteAlphabet* = {'A', 'a', 'C', 'c', 'G', 'g', 'T', 't', 'U', 'u'}
  abstractAlphabet* = {'N', 'n', 'B', 'b', 'D', 'd', 'H', 'h', 'V', 'v',
                       'W', 'w', 'S', 's', 'R', 'r', 'Y', 'y'}
  skipNucleotides* = {'B': {'A', 'a'}, 'b': {'A', 'a'}, 'D': {'C', 'c'},
                      'd': {'C', 'c'}, 'H': {'G', 'g'}, 'h': {'G', 'g'},
                      'V': {'T', 't'}, 'v': {'T', 't'},
                      'W': {'G', 'g', 'C', 'c'}, 'w': {'G', 'g', 'C', 'c'},
                      'S': {'A', 'a', 'T', 't'}, 's': {'A', 'a', 'T', 't'},
                      'R': {'C', 'c', 'T', 't'}, 'r': {'C', 'c', 'T', 't'},
                      'Y': {'A', 'a', 'G', 'g'},
                      'y': {'A', 'a', 'G', 'g'}}.toTable

template skip*(constraint, nt: char): bool =
  (skipNucleotides.hasKey(constraint)) and (nt in skipNucleotides[constraint])

template accept*(constraint, nt: char): bool =
  not constraint.skip(nt)

type
  Mutator* = object
    ## Object containing all constraints and parameters used for sequence
    ## mutation.
    constraintString*: string
    backgroundProbs*: Table[char, float]
    totalProb*: Table[char, float]
    mutationProb*: float
    consistentProb*: float
    stringLength*: int
    pairConstraints*: seq[tuple[i: int, j: int]]
    freeConstraints*: seq[int]

  DesignEngine* = ref object
    ## Object containing a population and scoring function for nucleic acid
    ## design.
    population*: seq[Compound]
    populationSize: int
    best*: Compound
    score*: float
    scoringFunction: proc(c: Compound): float
    settings*: Settings
    mutator*: Mutator

proc newEngine*(popSize: int, fitness: proc(c: Compound): float): DesignEngine =
  ## Creates a new `DesignEngine` with a population of size `popSize` and a
  ## fitness function fitness. For the fitness function smaller is better.
  new result
  result.populationSize = popSize
  result.scoringFunction = fitness
  result.mutator.backgroundProbs = [('A', 0.25), ('T', 0.25),
                                    ('C', 0.25), ('G', 0.25)].toTable
  result.mutator.mutationProb = 0.5
  result.mutator.consistentProb = 0.0
  result.population = @[]
  result.settings = settings()
  result.mutator.stringLength = 0
  result.mutator.pairConstraints = @[]
  result.mutator.freeConstraints = @[]
  result.mutator.totalProb = initTable[char, float]()

proc `background=`*(eg: DesignEngine, probs: Table[char, float]) =
  ## Sets the background probabilities of nucleotides.
  eg.mutator.backgroundProbs = probs
  for key, val in skipNucleotides:
    eg.mutator.totalProb[key] = 0.0
    for elem in "GATC":
      if key.accept(elem):
        eg.mutator.totalProb[key] += eg.mutator.backgroundProbs[elem]

proc `mutationProbability=`*(eg: DesignEngine, prob: float) =
  ## Sets the probability of a base to be mutated at each step.
  eg.mutator.mutationProb = prob

proc `consistentMutationProbability=`*(eg: DesignEngine, prob: float) =
  ## Sets the probability of a base pair, or unpaired base to be mutated
  ## consistent with a set of proposed secondary structures.
  eg.mutator.consistentProb = prob

proc `pattern=`*(eg: DesignEngine, pattern: string) =
  ## Sets a constraint on the bases at each position in the population.
  ## The constraint follows `pattern` in IUPAC notation:
  ##
  ## E.g: `H` corresponds to one of `A, C, T`, `N` to anything, and so on.
  eg.mutator.stringLength = pattern.len
  eg.mutator.constraintString = pattern

proc structureImpl(s: string, fc: var seq[int],
    pc: var seq[tuple[i: int, j: int]]) =
  var
    open: seq[int] = newSeqOfCap[int](s.len div 2)
    closedCount = 0
  pc.setLen(0)
  fc.setLen(0)
  for idx in 0 ..< s.len:
    if s[idx] == '(':
      open.add(idx)
    elif s[idx] == ')':
      pc.add((open[open.high - closedCount], idx))
      inc closedCount
    else:
      fc.add(idx)
    if closedCount == open.len: closedCount = 0

proc addStructure*(eg: DesignEngine, structure: string) =
  ## Adds a structure for consistent mutation to the DesignEngine `eg`.
  var
    pc: seq[tuple[i: int, j: int]] = @[]
    fc: seq[int] = @[]
    newPc: seq[tuple[i: int, j: int]] = @[]
    newFc: seq[int] = @[]
  structureImpl(structure, fc, pc)
  for idx in 0 ..< eg.mutator.freeConstraints.len:
    if eg.mutator.freeConstraints[idx] in fc:
      newFc.add(eg.mutator.freeConstraints[idx])
  for idx in 0 ..< eg.mutator.pairConstraints.len:
    if eg.mutator.pairConstraints[idx] in pc:
      newPc.add(eg.mutator.pairConstraints[idx])
  eg.mutator.freeConstraints = newFc
  eg.mutator.pairConstraints = newPc

proc `structure=`*(eg: DesignEngine, structure: string) =
  ## Sets a structure for consistent mutation for the DesignEngine `eg`.
  eg.mutator.pairConstraints.setLen(0)
  eg.mutator.freeConstraints.setLen(0)
  eg.addStructure(structure)

proc nucleotideChoice(mt: Mutator, constraint: char = 'N'): char =
  if constraint in concreteAlphabet: return constraint
  var
    sum = 0.0
    rand = rand(
      if mt.totalProb.hasKey(constraint):
        mt.totalProb[constraint]
      else:
        1.0
    )
  for ntide, val in mt.backgroundProbs.pairs:
    if constraint.skip(ntide): continue
    sum += val
    if rand < sum: return ntide

proc mutate*(mt: Mutator, source: string = ""): Compound =
  ## Returns a mutated Compound derived from `source`, according to the
  ## parameters set in the Mutator `mt`.
  var sequence: string
  if source.len == 0:
    sequence = newStringOfCap(mt.stringLength)
    for elem in mt.constraintString:
      sequence.add(mt.nucleotideChoice(elem))
  else:
    sequence = source
    for idx in 0 ..< source.len:
      if rand(1.0) > mt.mutationProb:
        continue
      sequence[idx] = mt.nucleotideChoice(mt.constraintString[idx])
    for elem in mt.pairConstraints:
      if rand(1.0) > mt.consistentProb or
          mt.constraintString[elem.j] in abstractAlphabet:
        continue
      let newNtide = mt.nucleotideChoice(mt.constraintString[elem.i])
      sequence[elem.i] = newNtide
      sequence[elem.j] = complement(newNtide)
    for elem in mt.freeConstraints:
      if rand(1.0) > mt.consistentProb:
        continue
      sequence[elem] = mt.nucleotideChoice(mt.constraintString[elem])
  return compound(sequence)

proc populate*(eg: DesignEngine) =
  ## Populates a DesignEngine `eg` according to its set properties.
  assert(eg.mutator.constraintString.len != 0)
  var
    source: string
    start: int
  if eg.best.isNil:
    source = ""
    start = 0
  else:
    source = $eg.best.sequence
    start = 1
    eg.population[0] = eg.best
  eg.population.setLen(eg.populationSize)
  for idx in start ..< eg.populationSize:
    eg.population[idx] = eg.mutator.mutate(source)

proc eval*(eg: DesignEngine) =
  ## Evaluates all members of the population stored in `eg` and selects the
  ## best.
  var
    values = newSeq[float](eg.populationSize)
    indices = toSeq(0 ..< eg.populationSize)
  for idx in 0 ..< eg.populationSize:
    values[idx] = eg.scoringFunction(eg.population[idx])
  indices.sort do (x, y: int) -> int:
    cmp(values[x], values[y])
  eg.best = eg.population[indices[0]]
  eg.score = values[indices[0]]

proc step*(eg: DesignEngine, iterations: int = 1) =
  ## Performs `iterations` steps of mutation and evaluation on the population in
  ## the DesignEngine `eg`.
  for idx in 0 ..< iterations:
    eg.populate
    eg.eval
