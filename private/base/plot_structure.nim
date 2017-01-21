#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc psRnaPlotSnoopA*(string: cstring; structure: cstring; ssfile: cstring;
                      relativeAccess: ptr cint; seqs: ptr cstring): cint {.cdecl,
    importc: "PS_rna_plot_snoop_a", dynlib: rnaLib.}

proc vrnaFilePsRnaplot*(seq: cstring; structure: cstring; file: cstring;
                        mdP: ptr VrnaMdT): cint {.cdecl,
    importc: "vrna_file_PS_rnaplot", dynlib: rnaLib.}

proc vrnaFilePsRnaplotA*(seq: cstring; structure: cstring; file: cstring;
                         pre: cstring; post: cstring; mdP: ptr VrnaMdT): cint {.cdecl,
    importc: "vrna_file_PS_rnaplot_a", dynlib: rnaLib.}

proc gmlRNA*(string: cstring; structure: cstring; ssfile: cstring; option: char): cint {.
    cdecl, importc: "gmlRNA", dynlib: rnaLib.}

proc ssvRnaPlot*(string: cstring; structure: cstring; ssfile: cstring): cint {.cdecl,
    importc: "ssv_rna_plot", dynlib: rnaLib.}

proc svgRnaPlot*(string: cstring; structure: cstring; ssfile: cstring): cint {.cdecl,
    importc: "svg_rna_plot", dynlib: rnaLib.}

proc xrnaPlot*(string: cstring; structure: cstring; ssfile: cstring): cint {.cdecl,
    importc: "xrna_plot", dynlib: rnaLib.}
