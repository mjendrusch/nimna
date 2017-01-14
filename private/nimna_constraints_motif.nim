#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

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
