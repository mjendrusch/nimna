#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

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

proc liftPreferences*(c: Compound): Compound {. discardable .} =
  ## Resets all soft constraints on a Compound to their default value.
  withRef c:
    vrnaScInit(c.vfc)
  result = c

proc initPreferences*(c: Compound): Compound {. discardable, inline .} =
  ## Initializes the soft constraint data structure in a Compound.
  liftPreferences(c)
