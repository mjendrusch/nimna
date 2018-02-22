#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import RNA
import nimna_types, nimna_cutils, nimna_compound

const
  vudExtLoop* = 1.UnstructuredOption
  vudHpLoop* = 2.UnstructuredOption
  vudIntLoop* = 4.UnstructuredOption
  vudMbLoop* = 8.UnstructuredOption
  vudMotif* = 16.UnstructuredOption
  vudAllLoops* = (Vrna_Unstructured_Domain_Ext_Loop or
      Vrna_Unstructured_Domain_Hp_Loop or Vrna_Unstructured_Domain_Int_Loop or
      Vrna_Unstructured_Domain_Mb_Loop).UnstructuredOption

template unstructuredOption*(x: varargs[UnstructuredOption]): UnstructuredOption =
  ## Merges a list of ``UnstructuredOptions`` into a single ``UnstructuredOption``
  var res = 0.char
  for elem in x:
    res = char(res.uint8 or elem.uint8)
  res.ConstraintOption

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

proc preferMotif*(c: Compound; motifSequence: string, energy: float,
    loopType: UnstructuredOption): Compound {. discardable .} =
    withRef c:
      vrnaUdAddMotif(c.vfc, motifSequence.cstring, energy, loopType.cuint)
    result = c

proc liftMotifs*(c: Compound): Compound {. discardable .} =
  withRef c:
    vrnaUdRemove(c.vfc)
  result = c
