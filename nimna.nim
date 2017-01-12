#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import private/RNA
import macros
import strutils
import math
import random

export RNA

{. experimental .}

## High level garbage collected interface to ViennaRNA. *Work in progress*.

type
  Compound* = ref object
    ## Represents a sequence of DNA or RNA together with folding parameters
    ## and results.
    vfc: ptr VrnaFoldCompoundT
  Settings* {. byref .} = VrnaMdT
    ## Represents a set of conditions for folding, such as for example
    ## temperature.
  Parameters* {. byref .} = VrnaParamT
    ## Represents a set of folding parameters, computed from Settings.
  ScaledParameters* {. byref .} = VrnaExpParamT
    ## Represents a set of partition function folding parameters,
    ## computed from Settings.
  ConstraintOption* = distinct cuint
    ## Represents the way a constraint on folding is stored and interpreted.
  Probabilities* = ref object
    ## Represents the base pair probability matrix of a Compound
    parent: Compound
    bppm: ptr FltOrDbl
  MotifError* = object of Exception

const
  vcNoHeader* = VRNA_CONSTRAINT_NO_HEADER.ConstraintOption
  vcDb* = VRNA_CONSTRAINT_DB.ConstraintOption
  vcdbEnforceBp* = VRNA_CONSTRAINT_DB_ENFORCE_BP.ConstraintOption
  vcdbPipe* = VRNA_CONSTRAINT_DB_PIPE.ConstraintOption
  vcdbDot* = VRNA_CONSTRAINT_DB_DOT.ConstraintOption
  vcdbX* = VRNA_CONSTRAINT_DB_X.ConstraintOption
  vcdbAngBrack* = VRNA_CONSTRAINT_DB_ANG_BRACK.ConstraintOption
  vcdbRndBrack* = VRNA_CONSTRAINT_DB_RND_BRACK.ConstraintOption
  vcdbIntramol* = VRNA_CONSTRAINT_DB_INTRAMOL.ConstraintOption
  vcdbIntermol* = VRNA_CONSTRAINT_DB_INTERMOL.ConstraintOption
  vcdbGquad* = VRNA_CONSTRAINT_DB_GQUAD.ConstraintOption
  vcdbDefault* = VRNA_CONSTRAINT_DB_DEFAULT.ConstraintOption
  vccExtLoop* = VRNA_CONSTRAINT_CONTEXT_EXT_LOOP.ConstraintOption
  vccHpLoop* = VRNA_CONSTRAINT_CONTEXT_HP_LOOP.ConstraintOption
  vccIntLoop* = VRNA_CONSTRAINT_CONTEXT_INT_LOOP.ConstraintOption
  vccIntLoopEnc* = VRNA_CONSTRAINT_CONTEXT_INT_LOOP_ENC.ConstraintOption
  vccMbLoop* = VRNA_CONSTRAINT_CONTEXT_MB_LOOP.ConstraintOption
  vccMbLoopEnc* = VRNA_CONSTRAINT_CONTEXT_MB_LOOP_ENC.ConstraintOption
  vccEnforce* = VRNA_CONSTRAINT_CONTEXT_ENFORCE.ConstraintOption
  vccNoRemove* = VRNA_CONSTRAINT_CONTEXT_NO_REMOVE.ConstraintOption
  vccAllLoops* = VRNA_CONSTRAINT_CONTEXT_ALL_LOOPS.ConstraintOption
  vcmDefault* = VRNA_OPTION_DEFAULT.ConstraintOption

# Utilities for interfacing with C

proc free(p: pointer) {. importc: "free", nodecl .}
template withRef(x, y: untyped) =
  GcRef(x)
  y
  GcUnref(x)
template `+`[T](p: ptr T, off: int): ptr T =
  cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))
template `[]`[T](p: ptr T, off: int): T =
  (p + off)[]

macro `.`*(c: Compound, field: string): auto =
  let ident = newIdentNode(!field.strVal)
  result = quote do:
    `c`.vfc[].`ident`

macro `.=`*[T](c: Compound, field: string, val: T): untyped =
  let ident = newIdentNode(!field.strVal)
  result = quote do:
    `c`.vfc[].`ident` = `val`

# Hard constraint handling:

template constraintOption*(x: varargs[ConstraintOption]): ConstraintOption =
  ## Merges a list of ``ConstraintOptions`` into a single ``ConstraintOption``
  var res = 0.char
  for elem in x:
    res = char(res.uint8 or elem.uint8)
  res.ConstraintOption

proc constrain*(c: Compound, constraint: cstring,
  option: ConstraintOption = vcdbDefault): Compound {. discardable .} =
  ## Add a secondary structure <constraint> in "((((...))))" format to a
  ## Compound. Returns the compound for further processing.
  withRef c:
    discard vrnaHcAddFromDb(c.vfc, constraint, option.cuint)
  result = c

proc forceUnpaired*(c: Compound, position: int,
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Add an ``unpaired`` constraint to the base at a position in the Compound.
  withRef c:
    vrnaHcAddUp(c.vfc, position.cint, option.char)
  result = c

proc forcePaired*(c: Compound; i, j: int;
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Add a ``paired`` constraint to the bases at a positions i and j
  ## in the Compound.
  withRef c:
    vrnaHcAddBp(c.vfc, i.cint, j.cint, option.char)
  result = c

proc liftConstraints*(c: Compound): Compound {. discardable .} =
  ## Lift all constraints from a Compound. Returns the Compound for further
  ## processing.
  withRef c:
    vrnaHcInit(c.vfc)
  result = c

proc initConstraints*(c: Compound): Compound {. discardable, inline .} =
  liftConstraints(c)

# Soft constraint handling:
proc preferUnpaired*(c: Compound; position: int; energy: float;
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Adds a soft constraint leaving a base at position unpaired
  ## with pseudo free energy (energy) to a Compound.
  withRef c:
    vrnaScAddUp(c.vfc, position.cint, energy.FltOrDbl, option.cuint)
  result = c

proc preferUnpaired*(c: Compound; energies: openarray[float],
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Sets unpaired constraint energies. Overrides all previous unpaired soft
  ## constraints.
  withRef c:
    vrnaScSetUp(c.vfc, energies[0].unsafeAddr, option.cuint)
  result = c

proc preferPaired*(c: Compound; i, j: int; energy: float;
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Adds a soft constraint leaving bases at positions i, j paired with
  ## each other with pseudo free energs (energy) to a Compound.
  withRef c:
    vrnaScAddBp(c.vfc, i.cint, j.cint, energy.FltOrDbl, option.cuint)
  result = c

proc preferPaired*[T: openarray[float]](c: Compound; energies: openarray[T],
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Sets paired constraint energies. Overrides all previous paired soft
  ## constraints.
  withRef c:
    vrnaScSetBp(c.vfc, cast[ptr ptr float](energies[0][0].unsafeAddr),
      option.cuint)
  result = c

proc preferPaired*(c: Compound; energies: openarray[float],
    option: ConstraintOption = vccAllLoops): Compound {. discardable .} =
  ## Sets paired constraint energies. Overrides all previous paired soft
  ## constraints.
  var pointers = newSeq[ptr float](c.length.int)
  for idx in 0 ..< c.length.int:
    pointers.add energies[idx * c.length.int].unsafeAddr
  withRef c:
    vrnaScSetBp(c.vfc, pointers[0].addr, option.cuint)
  result = c

# Ligand binding motifs

proc preferMotif*(c: Compound; motifSequence, motifStructure: string;
    energy: float, option: ConstraintOption = vcmDefault): Compound {. discardable .} =
  ## Adds a ligand binding motif of energy, sequence (motifSequence) and
  ## secondary structure (motifStructure) as a soft constraint to a Compound.
  withRef c:
    let success = vrnaScAddHiMotif(c.vfc, motifSequence.cstring,
      motifStructure.cstring, energy, option.cuint)
  if success == 0:
    raise newException(MotifError,
      "Motif " & motifSequence & " not found in " & $c.sequence & "!")
  result = c

proc liftPreferences*(c: Compound): Compound {. discardable .} =
  ## Resets all soft constraints on a Compound to their default value.
  withRef c:
    vrnaScInit(c.vfc)
  result = c

proc initPreferences*(c: Compound): Compound {. discardable, inline .} =
  ## Initializes the soft constraint data structure in a Compound.
  liftPreferences(c)

proc lift*(c: Compound): Compound {. discardable, inline .} =
  ## Resets all constraints in a Compound.
  liftConstraints(c)
  liftPreferences(c)

proc init*(c: Compound): Compound {. discardable, inline .} =
  ## Initializes all constraint data structure in a Compound.
  lift(c)

# Model Details handling:

macro settings*(xs: varargs[untyped]): Settings =
  ## Creates Settings from a set of directives.
  ## e.g.:
  ##
  ## `temperature = 20.0`
  let setting = gensym(nskVar)
  result = quote do:
    var `setting`: Settings
    vrnaMdSetDefault(unsafeAddr(`setting`))
  for elem in xs:
    assert(elem.len == 2)
    let
      field = elem[0]
      value = elem[1]
    result.add quote do:
      `setting`.`field` = `value`
  result.add setting

proc toParams*(s: Settings): Parameters =
  ## Convert Settings to Parameters
  var paramPtr = vrnaParams(s.unsafeAddr)
  swap(result, paramPtr[])
  free(paramPtr)

proc toScaledParams*(s: Settings): ScaledParameters =
  ## Converts Settings to ScaledParameters for partition function folding.
  var paramPtr = vrnaExpParams(s.unsafeAddr)
  swap(result, paramPtr[])
  free(paramPtr)

proc update*(c: Compound, p: Parameters): Compound {. discardable .} =
  ## Updates Parameters of a Compound. Returns the Compound for further
  ## processing.
  withRef c:
    vrnaParamsSubst(c.vfc, p.unsafeAddr)
  result = c

proc update*(c: Compound, p: ScaledParameters): Compound {. discardable .} =
  ## Updates ScaledParameters of a Compound. Returns the Compound for further
  ## processing.
  withRef c:
    vrnaExpParamsSubst(c.vfc, p.unsafeAddr)
  result = c

proc update*(c: Compound, s: Settings): Compound {. inline, discardable .} =
  ## Updates Parameters and ScaledParameters of a Compound from Settings.
  ## Returns the Compound for further processing.
  c.update(s.toParams)
  c.update(s.toScaledParams)
  result = c

proc freeCompound*(c: Compound) =
  foldCompoundFree(c.vfc)

proc compound*(sequence: string): Compound =
  ## Creates a Compound from a sequence string.
  new result, freeCompound
  result.vfc = foldCompound(
    cstring(sequence),
    cast[ptr VrnaMdT](nil),
    VrnaOptionDefault
  )

proc compound*(sequence: string, settings: Settings): Compound =
  ## Creates a Compound from a sequence string with Settings.
  new result, freeCompound
  result.vfc = foldCompound(
    cstring(sequence),
    settings.unsafeAddr,
    VrnaOptionDefault
  )

proc `[]`*(p: Probabilities; i, j: int): float =
  if i > p.parent.length.int or j > p.parent.length.int:
    raise newException(IndexError, "index out of bounds!")
  elif i < j:
    result = p.bppm[p.parent.iindx[i] - j]
  else:
    result = p.bppm[p.parent.iindx[j] - i]

proc probabilities*(c: Compound): Probabilities =
  ## Returns a Probabilities object for monitoring the base pair probabilities
  ## inside the Compound.
  new result
  let partFunc = c.expMatrices
  if partFunc[].`type` == VrnaMxDefault:
    result.bppm = partFunc[].union.default.probs
    result.parent = c
  else:
    raise newException(FieldError,
      "Compound does not contain the field `probs`")

proc prob*(c: Compound; i, j: int): float =
  ## Returns the probability of base-pairing at positions i and j in a Compound.
  c.probabilities[i, j]

template foldImpl(c, name: untyped): untyped =
  let
    sq = cast[cstring](c.sequence)
    structure = cast[ptr char](alloc0(sq.len * sizeOf(char)))
  defer: dealloc structure
  withRef c:
    result.E = name(c.vfc, structure)
  result.struc = $structure

proc pf*(c: Compound): tuple[E: float; struc: string] =
  ## Partition function folding for a Compound.
  ## Returns a tuple of ensemble energy and secondary structure.
  foldImpl(c, pf)

proc mfe*(c: Compound): tuple[E: float; struc: string] =
  ## Minimum free energy folding for a Compound.
  ## Returns a tuple of MFE and secondary structure.
  foldImpl(c, mfe)

proc pfDimer*(c: Compound): tuple[E: DimerEnergies; struc: string] =
  ## Partition function folding for a Compound (dimer).
  ## Returns a tuple of ensemble energy and secondary structure.
  foldImpl(c, pfDimer)

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
  ## A computation of the partition function has to be done before calling this.
  centroidImpl(c, c.sequence, vrnaCentroid(c.vfc, result.dist.unsafeAddr))

proc centroid*(p: Probabilities): tuple[dist: float; struc: string] =
  ## Computes the centroid structure of an ensemble stored in a Probabilities
  ## object.
  centroidImpl(p, p.parent.sequence,
    vrnaCentroidFromProbs(p.parent.length.cint, result.dist.unsafeAddr, p.bppm))

# Structure sampling from an ensemble

proc sample*(c: Compound): string =
  ## Samples a secondary structure from an ensemble according to its probability.
  withRef c:
    let structure = vrnaPBacktrack(c.vfc)
    result = $structure
  dealloc structure

# Utilities for plotting:

proc colorize(s: string, color: uint8): string =
  "\e[48;5;$2m$1\e[m".format(s, color)

type ColorScheme* = enum
  csGrayScale, csBlueRed

proc toGrayscale(f: float, gamma: float): string =
  var num = uint8(pow(f, gamma) * 25) + 232
  if num < 232: num = 255
  result = colorize("  ", num)

proc toBlueRed(f: float, gamma: float): string =
  var num = int(pow(f, gamma) * 12)
  if num < 6:
    num += 16
  else:
    num = 201 - num + 6
  result = colorize("  ", num.uint8)

proc densityPlot*(c: Compound, gamma: float, scheme: ColorScheme = csGrayScale) =
  ## Create a colored density plot of the base pairing probabilities in the
  ## Compound, in a terminal emulator compatible with ANSI-escapes.
  let toColorScheme = case scheme:
    of csGrayScale:
      toGrayscale
    of csBlueRed:
      toBlueRed
  echo "  ", ($c.sequence).join" "
  for i in 1 .. c.length.int:
    var seqI = " "
    for j in 1 .. c.length.int:
      if i == j:
        seqI.add(colorize("  ", 255))
      else:
        seqI.add(toColorScheme(c.prob(i, j), gamma))
    echo c.sequence[i - 1], seqI

# Read and write energy parameter files:
proc readPars*(path: string) =
  readParameterFile(path.cstring)
proc writePars*(path: string) =
  writeParameterFile(path.cstring)

# Utilities for DNA/RNA processing

proc complement*(a: char): char =
  ## Returns the complement of a DNA base.
  case a
  of 'a', 'A':
    'T'
  of 't', 'T', 'u', 'U':
    'A'
  of 'c', 'C':
    'G'
  of 'g', 'G':
    'C'
  else:
    'N'

proc randomDNA*(length: int): string =
  ## Returns a random DNA of a given length.
  result = newStringOfCap(length)
  for i in 0 ..< length:
    result.add random(['G', 'A', 'T', 'C'])

proc randomDNAofStructure*(struc: string): string =
  ## Returns a random DNA with a certain projected secondary structure.
  result = newString(struc.len)
  var
    open = newSeqOfCap[int](int(struc.len / 2 + 1))
    close = newSeqOfCap[int](int(struc.len / 2 + 1))
  for idx in 0 ..< struc.len:
    case struc[idx]
    of '(':
      open.add(idx)
    of ')':
      close.insert(idx, 0)
    else:
      result[idx] = ['G', 'A', 'T', 'C'].random
  for idx in 0 ..< open.len:
    result[open[idx]] = ['G', 'A', 'T', 'C'].random
    result[close[idx]] = result[open[idx]].complement

# TODO: This is growing too large. Split into multiple files.
