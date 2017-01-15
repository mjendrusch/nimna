#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc eval*(c: Compound, structure: string): float =
  ## Calculates the free energy associated with a secondary structure.
  withRef c:
    result = vrnaEvalStructure(c.vfc, structure.cstring).float

proc eval*(c: CompoundComparative, structure: string): float =
  ## Calculates the free energy associated with a secondary structure for an
  ## alignment of sequences.
  withRef c:
    result = vrnaEvalCovarStructure(c.vfc, structure.cstring).float

proc evalMove*(c: Compound; structure: string; a, b: int): float =
  ## Calculates the free energy associated with adding or removing a base pair.
  ## If one of a, b is positive, a base pair is added. else, a base pair is
  ## removed at the positions a, b.
  if a >= c.len or a <= -c.len:
    raise newException(IndexError,
      "`a` may not be greater than, or equal to the Compound's length.")
  if b >= c.len or b <= -c.len:
    raise newException(IndexError,
      "`b` may not be greater than, or equal to the Compound's length.")
  withRef c:
    result = vrnaEvalMove(c.vfc, structure.cstring, a.cint, b.cint)

proc evalAdd*(c: Compound; structure: string; a, b: Natural): float {. inline .} =
  ## Calculates the free energy associated with adding a base pair between bases
  ## a and b.
  evalMove(c, structure, a, b)

proc evalRemove*(c: Compound; structure: string; a, b: Natural): float {. inline .} =
  ## Calculates the free energy associated with removing a base pair between bases
  ## a and b.
  evalMove(c, structure, -a, -b)
