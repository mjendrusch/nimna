#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

type
  VrnaUnitEnergyE* {.size: sizeof(cint).} = enum
    VRNA_UNIT_J, VRNA_UNIT_KJ, VRNA_UNIT_CAL_IT, VRNA_UNIT_DACAL_IT,
    VRNA_UNIT_KCAL_IT, VRNA_UNIT_CAL, VRNA_UNIT_DACAL, VRNA_UNIT_KCAL,
    VRNA_UNIT_G_TNT, VRNA_UNIT_KG_TNT, VRNA_UNIT_T_TNT, VRNA_UNIT_EV, VRNA_UNIT_WH,
    VRNA_UNIT_KWH
  VrnaUnitTemperatureE* {.size: sizeof(cint).} = enum
    VRNA_UNIT_K, VRNA_UNIT_DEG_C, VRNA_UNIT_DEG_F, VRNA_UNIT_DEG_R, VRNA_UNIT_DEG_N,
    VRNA_UNIT_DEG_DE, VRNA_UNIT_DEG_RE, VRNA_UNIT_DEG_RO

proc vrnaConvertEnergy*(energy: cdouble; `from`: VrnaUnitEnergyE; to: VrnaUnitEnergyE): cdouble {.
    cdecl, importc: "vrna_convert_energy", importRna.}

proc vrnaConvertTemperature*(temp: cdouble; `from`: VrnaUnitTemperatureE;
                            to: VrnaUnitTemperatureE): cdouble {.cdecl,
    importc: "vrna_convert_temperature", importRna.}
