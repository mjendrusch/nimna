#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

#include data_structures
#import params

#const rnaLib = "./RNA.so"

var mirnatog* {.importc: "mirnatog", dynlib: rnaLib.}: cint


var f_monomer* {.importc: "F_monomer", dynlib: rnaLib.}: array[2, cdouble]


type
  VrnaDimerPfS* = object
    f0ab*: cdouble
    fab*: cdouble
    fcAB*: cdouble
    fa*: cdouble
    fb*: cdouble
  VrnaDimerPfT* = VrnaDimerPfS
  DimerEnergies* = VrnaDimerPfS



type
  VrnaDimerConcS* = object
    a0*: cdouble
    b0*: cdouble
    aBc*: cdouble
    aAc*: cdouble
    bBc*: cdouble
    ac*: cdouble
    bc*: cdouble
  VrnaDimerConcT* = VrnaDimerConcS


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
