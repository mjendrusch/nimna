#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  lxc37* {.importc: "lxc37", dynlib: rnaLib.}: cdouble

  stack37* {.importc: "stack37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, cint]]
  stackdH* {.importc: "stackdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, cint]]

  entropies* {.importc: "entropies", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, cint]]

  hairpin37* {.importc: "hairpin37", dynlib: rnaLib.}: array[31, cint]
  hairpindH* {.importc: "hairpindH", dynlib: rnaLib.}: array[31, cint]
  bulge37* {.importc: "bulge37", dynlib: rnaLib.}: array[31, cint]
  bulgedH* {.importc: "bulgedH", dynlib: rnaLib.}: array[31, cint]
  internalLoop37* {.importc: "internal_loop37", dynlib: rnaLib.}: array[31, cint]
  internalLoopdH* {.importc: "internal_loopdH", dynlib: rnaLib.}: array[31, cint]
  internal2Energy* {.importc: "internal2_energy", dynlib: rnaLib.}: cint
  oldMismatch37* {.importc: "old_mismatch_37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]
  mismatchI37* {.importc: "mismatchI37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchIdH* {.importc: "mismatchIdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch1nI37* {.importc: "mismatch1nI37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch23I37* {.importc: "mismatch23I37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch1nIdH* {.importc: "mismatch1nIdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch23IdH* {.importc: "mismatch23IdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchH37* {.importc: "mismatchH37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchM37* {.importc: "mismatchM37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchHdH* {.importc: "mismatchHdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchMdH* {.importc: "mismatchMdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchExt37* {.importc: "mismatchExt37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]
  mismatchExtdH* {.importc: "mismatchExtdH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, array[5, cint]]]
  dangle537* {.importc: "dangle5_37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, cint]]

  dangle337* {.importc: "dangle3_37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, cint]]

  dangle3DH* {.importc: "dangle3_dH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, cint]]

  dangle5DH* {.importc: "dangle5_dH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[5, cint]]
  int1137* {.importc: "int11_37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, cint]]]]

  int11DH* {.importc: "int11_dH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, cint]]]]
  int2137* {.importc: "int21_37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, cint]]]]]

  int21DH* {.importc: "int21_dH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, cint]]]]]
  int2237* {.importc: "int22_37", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, array[5, cint]]]]]]

  int22DH* {.importc: "int22_dH", dynlib: rnaLib.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, array[5, cint]]]]]]

  mlBase37* {.importc: "ML_BASE37", dynlib: rnaLib.}: cint
  mlBasedH* {.importc: "ML_BASEdH", dynlib: rnaLib.}: cint
  mlClosing37* {.importc: "ML_closing37", dynlib: rnaLib.}: cint
  mlClosingdH* {.importc: "ML_closingdH", dynlib: rnaLib.}: cint
  mlIntern37* {.importc: "ML_intern37", dynlib: rnaLib.}: cint
  mlInterndH* {.importc: "ML_interndH", dynlib: rnaLib.}: cint
  tripleC37* {.importc: "TripleC37", dynlib: rnaLib.}: cint
  tripleCdH* {.importc: "TripleCdH", dynlib: rnaLib.}: cint
  multipleCA37* {.importc: "MultipleCA37", dynlib: rnaLib.}: cint
  multipleCAdH* {.importc: "MultipleCAdH", dynlib: rnaLib.}: cint
  multipleCB37* {.importc: "MultipleCB37", dynlib: rnaLib.}: cint
  multipleCBdH* {.importc: "MultipleCBdH", dynlib: rnaLib.}: cint

  MAX_NINIO* {.importc: "MAX_NINIO", dynlib: rnaLib.}: cint

  ninio37* {.importc: "ninio37", dynlib: rnaLib.}: cint
  niniodH* {.importc: "niniodH", dynlib: rnaLib.}: cint

  terminalAU37* {.importc: "TerminalAU37", dynlib: rnaLib.}: cint
  terminalAUdH* {.importc: "TerminalAUdH", dynlib: rnaLib.}: cint

  duplexInit37* {.importc: "DuplexInit37", dynlib: rnaLib.}: cint
  duplexInitdH* {.importc: "DuplexInitdH", dynlib: rnaLib.}: cint

  tetraloops* {.importc: "Tetraloops", dynlib: rnaLib.}: ptr char

  tetraloop37* {.importc: "Tetraloop37", dynlib: rnaLib.}: ptr cint

  tetraloopdH* {.importc: "TetraloopdH", dynlib: rnaLib.}: ptr cint
  triloops* {.importc: "Triloops", dynlib: rnaLib.}: ptr char

  triloop37* {.importc: "Triloop37", dynlib: rnaLib.}: ptr cint

  triloopdH* {.importc: "TriloopdH", dynlib: rnaLib.}: ptr cint

  hexaloops* {.importc: "Hexaloops", dynlib: rnaLib.}: ptr char

  hexaloop37* {.importc: "Hexaloop37", dynlib: rnaLib.}: ptr cint

  hexaloopdH* {.importc: "HexaloopdH", dynlib: rnaLib.}: ptr cint

  gQuadAlpha37* {.importc: "GQuadAlpha37", dynlib: rnaLib.}: cint
  gQuadAlphadH* {.importc: "GQuadAlphadH", dynlib: rnaLib.}: cint
  gQuadBeta37* {.importc: "GQuadBeta37", dynlib: rnaLib.}: cint
  gQuadBetadH* {.importc: "GQuadBetadH", dynlib: rnaLib.}: cint
  tmeasure* {.importc: "Tmeasure", dynlib: rnaLib.}: cdouble
