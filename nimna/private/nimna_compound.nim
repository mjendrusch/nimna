#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import macros
import RNA
import nimna_types

{. experimental .}

# Utilities

template recomputePfImpl*(c: untyped): untyped =
  if not c.hasPf:
    if c.isDimer:
      discard c.pfDimer
    else:
      discard c.pf

# Accessors

macro `.`*(c: Compound, field: untyped): auto =
  result = quote do:
    `c`.vfc[].`field`

macro `.=`*[T](c: Compound, field: untyped, val: T): untyped =
  result = quote do:
    `c`.vfc[].`field` = `val`

# Constructors / Destructors

proc freeCompound(c: Compound | CompoundComparative | Compound2D) =
  foldCompoundFree(c.vfc)

proc isDimer*(c: Compound): bool =
  c.vfc.cutpoint != -1

proc compound*(sequence: string): Compound =
  ## Creates a Compound from a sequence string.
  new result, freeCompound
  result.hasPf = false
  result.vfc = foldCompound(
    cstring(sequence),
    cast[ptr VrnaMdT](nil),
    VrnaOptionDefault
  )

proc compound*(sequences: openarray[string]): CompoundComparative =
  ## Creates a Compound from a sequence alignment stored as a set of sequences.
  new result, freeCompound
  result.hasPf = false
  let alignment = allocCStringArray(sequences)
  defer: deallocCStringArray(alignment)
  result.vfc = foldCompoundComparative(
    alignment,
    cast[ptr VrnaMdT](nil),
    VrnaOptionDefault
  )

proc compound*(al: Alignment): CompoundComparative =
  ## Creates a Compound from an Alignment.
  new result.Compound, freeCompound
  result.hasPf = false
  result.vfc = foldCompoundComparative(
    al.algn,
    cast[ptr VrnaMdT](nil),
    VrnaOptionDefault
  )

proc dimer*(sequence1, sequence2: string): Compound =
  ## Creates a Compound containing a dimer.
  var sequence = sequence1
  sequence &= "&"
  sequence &= sequence2
  result = compound(sequence)
  result.isD = true

proc compound2D*(sequence, reference1, reference2: string): Compound2D =
  ## Creates a Compound for 2DFold from a sequence string,
  ## together with two reference structures.
  new result, freeCompound
  result.hasPf = false
  result.vfc = foldCompoundTwoD(
    cstring(sequence),
    cstring(reference1),
    cstring(reference2),
    cast[ptr VrnaMdT](nil),
    VrnaOptionDefault
  )

proc compound*(sequence: string, settings: Settings): Compound =
  ## Creates a Compound from a sequence string with Settings.
  new result, freeCompound
  result.hasPf = false
  result.vfc = foldCompound(
    cstring(sequence),
    settings.unsafeAddr,
    VrnaOptionDefault
  )

proc dimer*(sequence1, sequence2: string, settings: Settings): Compound =
  ## Creates a Compound containing a dimer.
  var sequence = sequence1
  sequence &= "&"
  sequence &= sequence2
  result = compound(sequence, settings)
  result.isD = true

proc compound2D*(sequence, reference1, reference2: string,
    settings: Settings): Compound2D =
  ## Creates a Compound from a sequence string with Settings.
  new result.Compound, freeCompound
  result.hasPf = false
  result.vfc = foldCompoundTwoD(
    cstring(sequence),
    cstring(reference1),
    cstring(reference2),
    settings.unsafeAddr,
    VrnaOptionDefault
  )

template len*(c: Compound): int =
  c.length.int

# Iterators
