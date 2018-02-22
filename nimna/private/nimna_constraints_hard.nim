#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import RNA
import nimna_types, nimna_cutils

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
