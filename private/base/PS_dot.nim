#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const
  VRNA_PLOT_PROBABILITIES_BP* = 1
  VRNA_PLOT_PROBABILITIES_ACC* = 2
  VRNA_PLOT_PROBABILITIES_UD* = 4
  VRNA_PLOT_PROBABILITIES_UD_LIN* = 8
  VRNA_PLOT_PROBABILITIES_SD* = 16
  VRNA_PLOT_PROBABILITIES_SC_MOTIF* = 32
  VRNA_PLOT_PROBABILITIES_SC_UP* = 64
  VRNA_PLOT_PROBABILITIES_SC_BP* = 128
  VRNA_PLOT_PROBABILITIES_DEFAULT* = (vrna_Plot_Probabilities_Bp or
      vrna_Plot_Probabilities_Sd or vrna_Plot_Probabilities_Sc_Motif or
      vrna_Plot_Probabilities_Ud_Lin)

type
  VrnaDotplotAuxdataT* = object
    comment*: cstring
    title*: cstring
    top*: ptr ptr VrnaDataLinT
    topTitle*: cstringArray
    bottom*: ptr ptr VrnaDataLinT
    bottomTitle*: cstringArray
    left*: ptr ptr VrnaDataLinT
    leftTitle*: cstringArray
    right*: ptr ptr VrnaDataLinT
    rightTitle*: cstringArray


proc vrnaPlotDpEPS*(filename: cstring; sequence: cstring; upper: ptr VrnaPlistT;
                   lower: ptr VrnaPlistT; auxdata: ptr VrnaDotplotAuxdataT;
                   options: cuint): cint {.cdecl, importc: "vrna_plot_dp_EPS",
                                        dynlib: rnaLib.}
proc pS_colorDotPlot*(string: cstring; pi: ptr Cpair; filename: cstring): cint {.cdecl,
    importc: "PS_color_dot_plot", dynlib: rnaLib.}
proc pS_colorDotPlotTurn*(seq: cstring; pi: ptr Cpair; filename: cstring; winSize: cint): cint {.
    cdecl, importc: "PS_color_dot_plot_turn", dynlib: rnaLib.}

proc pS_dotPlotList*(seq: cstring; filename: cstring; pl: ptr Plist; mf: ptr Plist;
                    comment: cstring): cint {.cdecl, importc: "PS_dot_plot_list",
    dynlib: rnaLib.}
proc vrnaPlotDpPS_list*(seq: cstring; cp: cint; wastlfile: cstring; pl: ptr Plist;
                       mf: ptr Plist; comment: cstring): cint {.cdecl,
    importc: "vrna_plot_dp_PS_list", dynlib: rnaLib.}
proc pS_dotPlotTurn*(seq: cstring; pl: ptr Plist; filename: cstring; winSize: cint): cint {.
    cdecl, importc: "PS_dot_plot_turn", dynlib: rnaLib.}
