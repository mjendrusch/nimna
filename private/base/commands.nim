#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.



type
  VrnaCmdT* = vrnaCommandS


const
  VRNA_CMD_PARSE_HC* = 1


const
  VRNA_CMD_PARSE_SC* = 2


const
  VRNA_CMD_PARSE_UD* = 4


const
  VRNA_CMD_PARSE_SD* = 8


const
  VRNA_CMD_PARSE_DEFAULTS* = (vrna_Cmd_Parse_Hc or vrna_Cmd_Parse_Sc or
      vrna_Cmd_Parse_Ud or vrna_Cmd_Parse_Sd)


type
  VrnaCommandE* {.size: sizeof(cint).} = enum
    VRNA_CMD_ERROR = - 1, VRNA_CMD_LAST = 0, VRNA_CMD_HC, VRNA_CMD_SC, VRNA_CMD_MOTIF,
    VRNA_CMD_UD, VRNA_CMD_SD



type
  VrnaCommandS* = object
    `type`*: VrnaCommandE
    data*: pointer



proc vrnaFileCommandsRead*(filename: cstring; options: cuint): ptr VrnaCmdT {.cdecl,
    importc: "vrna_file_commands_read", dynlib: rnaLib.}

proc vrnaFileCommandsApply*(vc: ptr VrnaFoldCompoundT; filename: cstring;
                           options: cuint): cint {.cdecl,
    importc: "vrna_file_commands_apply", dynlib: rnaLib.}

proc vrnaCommandsApply*(vc: ptr VrnaFoldCompoundT; commands: ptr VrnaCmdT;
                       options: cuint): cint {.cdecl,
    importc: "vrna_commands_apply", dynlib: rnaLib.}

proc vrnaCommandsFree*(commands: ptr VrnaCmdT) {.cdecl,
    importc: "vrna_commands_free", dynlib: rnaLib.}
