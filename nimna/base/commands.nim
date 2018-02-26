#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_CMD_PARSE_HC* = 1
  VRNA_CMD_PARSE_SC* = 2
  VRNA_CMD_PARSE_UD* = 4
  VRNA_CMD_PARSE_SD* = 8
  VRNA_CMD_PARSE_DEFAULTS* = (vrna_Cmd_Parse_Hc or vrna_Cmd_Parse_Sc or
      vrna_Cmd_Parse_Ud or vrna_Cmd_Parse_Sd)

proc vrnaFileCommandsRead*(filename: cstring; options: cuint): ptr VrnaCmdT {.cdecl,
    importc: "vrna_file_commands_read", importRna.}

proc vrnaFileCommandsApply*(vc: ptr VrnaFoldCompoundT; filename: cstring;
                           options: cuint): cint {.cdecl,
    importc: "vrna_file_commands_apply", importRna.}

proc vrnaCommandsApply*(vc: ptr VrnaFoldCompoundT; commands: ptr VrnaCmdT;
                       options: cuint): cint {.cdecl,
    importc: "vrna_commands_apply", importRna.}

proc vrnaCommandsFree*(commands: ptr VrnaCmdT) {.cdecl,
    importc: "vrna_commands_free", importRna.}
