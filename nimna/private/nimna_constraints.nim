#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

## .. include:: ../../docs/constraints.txt

import RNA
import nimna_types, nimna_compound

import nimna_constraints_hard
import nimna_constraints_soft
import nimna_constraints_motif
export nimna_constraints_hard
export nimna_constraints_soft
export nimna_constraints_motif

proc lift*(c: Compound): Compound {. discardable, inline .} =
  ## Resets all constraints in a Compound.
  liftConstraints(c)
  liftPreferences(c)
  liftMotifs(c)

proc init*(c: Compound): Compound {. discardable, inline .} =
  ## Initializes all constraint data structures in a Compound.
  lift(c)
