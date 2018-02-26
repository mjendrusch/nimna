#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

## .. include:: ../../docs/model.txt

import macros
import RNA
import nimna_types, nimna_cutils

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
  c.hasPf = false
  result = c

proc update*(c: Compound, p: ScaledParameters): Compound {. discardable .} =
  ## Updates ScaledParameters of a Compound. Returns the Compound for further
  ## processing.
  withRef c:
    vrnaExpParamsSubst(c.vfc, p.unsafeAddr)
  c.hasPf = false
  result = c

proc update*(c: Compound, s: Settings): Compound {. inline, discardable .} =
  ## Updates Parameters and ScaledParameters of a Compound from Settings.
  ## Returns the Compound for further processing.
  c.update(s.toParams)
  c.update(s.toScaledParams)
  result = c
