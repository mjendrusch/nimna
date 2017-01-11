#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import RNA
import macros
import strutils
import math
import os
import random

export RNA

{. experimental .}

type
  CompoundPtr* = ptr VrnaFoldCompoundT
  Compound* {. byref .} = VrnaFoldCompoundT
  SettingsPtr* = ptr Settings
  Settings* {. byref .} = VrnaMdT
  Parameters* {. byref .} = VrnaParamT
  ScaledParameters* {. byref .} = VrnaExpParamT
  ConstraintOption* = distinct cuint

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

template `%`(str: string; a: tuple): string =
  var intermediate: seq[string] = @[]
  for _, val in a.fieldPairs:
    intermediate.add($val)
  str % intermediate

proc free(p: pointer) {. importc: "free", nodecl .}

# Hard constraint handling:

template constraintOption*(x: varargs[char]): ConstraintOption =
  var res = 0.char
  for elem in x:
    res = char(res.uint8 or elem.uint8)
  res.ConstraintOption

proc constrain*(c: var Compound, constraint: cstring,
  option: ConstraintOption = vcdbDefault): var Compound {. discardable .} =
  ## Add a secondary structure <constraint> in "((((...))))" format to a
  ## Compound. Returns the compound for further processing.
  discard vrnaHcAddFromDb(addr(c), constraint, option.cuint)
  result = c

proc forceUnpaired*(c: var Compound, position: int,
    option: ConstraintOption = vccAllLoops): var Compound {. discardable .} =
  ## Add an ``unpaired`` constraint to the base at a position in the Compound.
  vrnaHcAddUp(addr(c), position.cint, option.char)
  result = c

proc forcePaired*(c: var Compound; i, j: int;
    option: ConstraintOption = vccAllLoops): var Compound {. discardable .} =
  ## Add a ``paired`` constraint to the bases at a positions i and j
  ## in the Compound.
  vrnaHcAddBp(addr(c), i.cint, j.cint, option.char)
  result = c

proc lift*(c: var Compound): var Compound {. discardable .} =
  ## Lift all constraints from a Compound. Returns the Compound for further
  ## processing.
  vrnaHcInit(c.addr)
  result = c

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

proc update*(c: var Compound, p: Parameters): var Compound {. discardable .} =
  ## Updates Parameters of a Compound. Returns the Compound for further
  ## processing.
  vrnaParamsSubst(c.addr, p.unsafeAddr)
  result = c

proc update*(c: var Compound, p: ScaledParameters): var Compound {. discardable .} =
  ## Updates ScaledParameters of a Compound. Returns the Compound for further
  ## processing.
  vrnaExpParamsSubst(c.addr, p.unsafeAddr)
  result = c

proc update*(c: var Compound, s: Settings): var Compound {. inline, discardable .} =
  ## Updates Parameters and ScaledParameters of a Compound from Settings.
  ## Returns the Compound for further processing.
  c.update(s.toParams)
  c.update(s.toScaledParams)
  result = c

proc freeCompound*(c: Compound) =
  ## Reimplements the Compound destructor from ViennaRNA to work with nim
  ## destructors.
  if unsafeAddr(c) != nil:
    free(c.iindx)
    free(c.jindx)
    free(c.params)
    free(c.expParams)
    # TODO: add rest of general frees
    case c.`type`
    of VrnaFcTypeSingle:
      free(c.sequence)
      free(c.sequence_encoding)
      free(c.sequence_encoding2)
      free(c.ptype)
      free(c.ptypePfCompat)
      # TODO: vrna_sc_free(c.sc.unsafeAddr)
    of VrnaFcTypeComparative:
      for idx in 0 ..< c.nSeq:
        free(c.sequences[idx])
        free(cast[array[0..0, ptr cshort]](c.s)[idx])
        free(cast[array[0..0, ptr cshort]](c.s5)[idx])
        free(cast[array[0..0, ptr cshort]](c.s3)[idx])
        free(cast[array[0..0, ptr cushort]](c.a2s)[idx])
        free(c.ss[idx])
      free(c.sequences)
      free(c.consSeq)
      free(c.sCons)
      free(c.s)
      free(c.s5)
      free(c.s3)
      free(c.ss)
      free(c.a2s)
      free(c.pscore)
      free(c.pscorePfCompat)
      if c.scs != nil:
        for idx in 0 ..< c.nSeq:
          # TODO: vrna_sc_free(c.scs[idx])
          discard
        free(c.scs)
    else:
      discard

proc `=destroy`*(c: Compound) = freeCompound(c)
  ## Compound Destructor.

proc compound*(sequence: string): Compound =
  ## Creates a Compound from a sequence string.
  result = foldCompound(
    cstring(sequence),
    cast[ptr VrnaMdT](nil),
    VrnaOptionDefault
  )[]

proc compound*(sequence: string, settings: Settings): Compound =
  ## Creates a Compound from a sequence string with Settings.
  result = foldCompound(
    cstring(sequence),
    settings.unsafeAddr,
    VrnaOptionDefault
  )[]

proc rawProbabilities*(c: Compound): ptr FltOrDbl =
  ## Returns a pointer to the base pair probability array of a Compound.
  let partFunc = c.expMatrices
  if partFunc[].`type` == VrnaMxDefault:
    result = partFunc[].union.default.probs
  else:
    result = nil

proc prob*(c: Compound; i, j: int): FltOrDbl =
  ## Returns the probability of base-pairing at positions i and j in a Compound.
  template `+`[T](p: ptr T, off: int): ptr T =
    cast[ptr type(p[])](cast[ByteAddress](p) +% off * sizeof(p[]))
  template `[]`[T](p: ptr T, off: int): T =
    (p + off)[]
  if i > type(i)(c.length) or j > type(j)(c.length):
    raise newException(IndexError, "index out of bounds!")
  let partFunc = c.expMatrices
  if partFunc[].`type` == VrnaMxDefault:
    if i < j:
      result = partFunc[].union.default.probs[c.iindx[i] - j]
    else:
      result = partFunc[].union.default.probs[c.iindx[j] - i]
  else:
    raise newException(FieldError,
      "The provided Compound is not of `type` VrnaMxDefault!")

proc pfImpl(c: Compound): tuple[E: float; struc: string] =
  let sq = cast[cstring](c.sequence)
  let structure = cast[ptr char](alloc0(sq.len * sizeOf(char)))
  result.E = pf(unsafeAddr(c), structure)
  result.struc = $structure

proc pf*(c: Compound{lvalue}): tuple[E: float; struc: string] = pfImpl(c)
  ## Partition function folding for an lvalue Compound.
  ## Returns a tuple of ensemble energy and secondary structure.

proc pf*(c: Compound{~lvalue}): tuple[E: float; struc: string] =
  ## Partition function folding for an rvalue Compound.
  ## Returns a tuple of ensemble energy and secondary structure and reclaims
  ## the memory of the Compound, as nim does not do this automatically.
  result = pfImpl(c)
  freeCompound(c)

proc mfeImpl(c: Compound): tuple[E: float; struc: string] =
  let sq = cast[cstring](c.sequence)
  let structure = cast[ptr char](alloc0(sq.len * sizeOf(char)))
  result.E = mfe(unsafeAddr(c), structure)
  result.struc = $structure

proc mfe*(c: Compound{lvalue}): tuple[E: float; struc: string] = mfeImpl(c)
  ## Minimum free energy folding for an lvalue Compound.
  ## Returns a tuple of MFE and secondary structure.

proc mfe*(c: Compound{~lvalue}): tuple[E: float; struc: string] =
  ## Minimum free energy folding for an rvalue Compound.
  ## Returns a tuple of MFE and secondary structure and reclaims
  ## the memory of the Compound, as nim does not do this automatically.
  result = mfeImpl(c)
  freeCompound(c)

proc pfDimerImpl(c: Compound): tuple[E: DimerEnergies; struc: string] =
  let sq = cast[cstring](c.sequence)
  let structure = cast[ptr char](alloc0(sq.len * sizeOf(char)))
  result.E = pfDimer(unsafeAddr(c), structure)
  result.struc = $structure

proc pfDimer*(c: Compound{lvalue}): tuple[E: DimerEnergies; struc: string] = pfDimerImpl(c)
  ## Partition function folding for an lvalue Compound (dimer).
  ## Returns a tuple of ensemble energy and secondary structure.

proc pfDimer*(c: Compound{~lvalue}): tuple[E: DimerEnergies; struc: string] =
  ## Partition function folding for an rvalue Compound (dimer).
  ## Returns a tuple of ensemble energy and secondary structure and reclaims
  ## the memory of the Compound, as nim does not do this automatically.
  result = pfDimerImpl(c)
  freeCompound(c)

proc mfeDimerImpl(c: Compound): tuple[E: float; struc: string] =
  let sq = cast[cstring](c.sequence)
  let structure = cast[ptr char](alloc0(sq.len * sizeOf(char)))
  result.E = mfeDimer(unsafeAddr(c), structure)
  result.struc = $structure

proc mfeDimer*(c: Compound{lvalue}): tuple[E: float; struc: string] = mfeDimerImpl(c)
  ## Minimum free energy folding for an lvalue Compound (dimer).
  ## Returns a tuple of MFE and secondary structure.

proc mfeDimer*(c: Compound{~lvalue}): tuple[E: float; struc: string] =
  ## Minimum free energy folding for an rvalue Compound (dimer).
  ## Returns a tuple of MFE and secondary structure and reclaims
  ## the memory of the Compound, as nim does not do this automatically.
  result = mfeDimerImpl(c)
  freeCompound(c)

# Utilities for plotting:

proc colorize(s: string, color: uint8): string =
  "\e[48;5;$2m$1\e[m".format(s, color)

type ColorScheme = enum
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

proc densityPlot*(c: Compound, gamma: float, scheme: ColorScheme = csBlueRed) =
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

# Utilities for DNA/RNA processing

proc complement*(a: char): char =
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
  result = newStringOfCap(length)
  for i in 0 ..< length:
    result.add random(['G', 'A', 'T', 'C'])

proc randomDNAofStructure*(struc: string): string =
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

when isMainModule:
  import commandeer

  proc main =
    commandline:
      argument sequence, string
      option T, float, "temperature", "T", 37.0
      option gamma, float, "gamma", "g", 1.0
      option movie, bool, "movie", "m"
      option grayScale, bool, "grayscale", "G"
      exitoption "help", "h",
                 "Usage: testPf <string>"
      errormsg "Thou hast fudged up!"
    var
      comp = compound(sequence)
      testComp = compound"GGAGGGAAACCCCC"
      scale = if grayScale:
          csGrayScale
        else:
          csBlueRed
    comp.update settings(temperature = T)

    if '&' in sequence:
      echo "Folding dimer at $1°C --------------------------------------------------" % $T
      echo "Energies: $1 \n Structure: $2                                           " % comp.pfDimer
      echo "Energy: $1 \n Structure: $2                                             " % comp.mfeDimer
      echo "Probability density plot at gamma = $1                                  " % $gamma
      comp.densityPlot gamma, scale
    else:
      if movie:
        randomize()
        for i in -100..100:
          # sleep(100)
          # var comp = compound(randomDNAOfStructure("(((((...)))))"))
          if i != -100:
            echo "\e[$1A" % $(comp.length + 9)
            discard
          comp.update settings(temperature = T + i.float / 10)
          echo "Folding at $1°C --------------------------------------------------------" % $(T + i.float / 10)
          echo "Ensemble Energy: $1\nEnsemble Structure: $2                             " % comp.pf
          echo "MFE: $1\nMFE Structure: $2                                              " % comp.mfe
          echo "Sequence:      $1                                                       " % sequence
          echo "Probability density plot at gamma = $1                                  " % $(gamma)
          comp.densityPlot gamma, scale
      else:
        comp.update settings(temperature = T)
        echo "Folding at $1°C --------------------------------------------------------" % $T
        echo "Ensemble Energy: $1\nEnsemble Structure: $2                             " % comp.pf
        echo "MFE: $1\nMFE Structure: $2                                              " % comp.mfe
        echo "Sequence:      $1                                                       " % sequence
        echo "Probability density plot at gamma = $1                                  " % $(gamma)
        comp.densityPlot gamma, scale
    echo "---------------------------------------------------------- done."

  main()
