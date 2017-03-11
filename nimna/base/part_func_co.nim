#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  mirnatog* {.importc: "mirnatog", dynlib: rnaLib.}: cint
  f_monomer* {.importc: "F_monomer", dynlib: rnaLib.}: array[2, cdouble]

proc pfDimer*(vc: ptr VrnaFoldCompoundT; structure: ptr char): VrnaDimerPfT {.cdecl,
    importc: "vrna_pf_dimer", dynlib: rnaLib.}

proc pfDimerProbs*(fab: cdouble; fa: cdouble; fb: cdouble; prAB: ptr VrnaPlistT;
                     prA: ptr VrnaPlistT; prB: ptr VrnaPlistT; alength: cint;
                     expParams: ptr VrnaExpParamT) {.cdecl,
   importc: "vrna_pf_dimer_probs", dynlib: rnaLib.}

proc pfDimerConcentrations*(fcAB: cdouble; fcAA: cdouble; fcBB: cdouble;
                              fea: cdouble; feb: cdouble; startconc: ptr cdouble;
                              expParams: ptr VrnaExpParamT): ptr VrnaDimerConcT {.
   cdecl, importc: "vrna_pf_dimer_concentrations", dynlib: rnaLib.}
