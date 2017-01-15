#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

include nimna_constraints_hard
include nimna_constraints_soft
include nimna_constraints_motif

proc lift*(c: Compound): Compound {. discardable, inline .} =
  ## Resets all constraints in a Compound.
  liftConstraints(c)
  liftPreferences(c)
  liftMotifs(c)

proc init*(c: Compound): Compound {. discardable, inline .} =
  ## Initializes all constraint data structure in a Compound.
  lift(c)
