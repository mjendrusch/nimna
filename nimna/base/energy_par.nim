#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

var
  lxc37* {.importc: "lxc37", importRna.}: cdouble

  stack37* {.importc: "stack37", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, cint]]
  stackdH* {.importc: "stackdH", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, cint]]

  entropies* {.importc: "entropies", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, cint]]

  hairpin37* {.importc: "hairpin37", importRna.}: array[31, cint]
  hairpindH* {.importc: "hairpindH", importRna.}: array[31, cint]
  bulge37* {.importc: "bulge37", importRna.}: array[31, cint]
  bulgedH* {.importc: "bulgedH", importRna.}: array[31, cint]
  internalLoop37* {.importc: "internal_loop37", importRna.}: array[31, cint]
  internalLoopdH* {.importc: "internal_loopdH", importRna.}: array[31, cint]
  internal2Energy* {.importc: "internal2_energy", importRna.}: cint
  oldMismatch37* {.importc: "old_mismatch_37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]
  mismatchI37* {.importc: "mismatchI37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchIdH* {.importc: "mismatchIdH", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch1nI37* {.importc: "mismatch1nI37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch23I37* {.importc: "mismatch23I37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch1nIdH* {.importc: "mismatch1nIdH", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatch23IdH* {.importc: "mismatch23IdH", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchH37* {.importc: "mismatchH37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchM37* {.importc: "mismatchM37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchHdH* {.importc: "mismatchHdH", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchMdH* {.importc: "mismatchMdH", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]

  mismatchExt37* {.importc: "mismatchExt37", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]
  mismatchExtdH* {.importc: "mismatchExtdH", importRna.}: array[nbpairs + 1,
    array[5, array[5, cint]]]
  dangle537* {.importc: "dangle5_37", importRna.}: array[nbpairs + 1,
    array[5, cint]]

  dangle337* {.importc: "dangle3_37", importRna.}: array[nbpairs + 1,
    array[5, cint]]

  dangle3DH* {.importc: "dangle3_dH", importRna.}: array[nbpairs + 1,
    array[5, cint]]

  dangle5DH* {.importc: "dangle5_dH", importRna.}: array[nbpairs + 1,
    array[5, cint]]
  int1137* {.importc: "int11_37", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, cint]]]]

  int11DH* {.importc: "int11_dH", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, cint]]]]
  int2137* {.importc: "int21_37", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, cint]]]]]

  int21DH* {.importc: "int21_dH", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, cint]]]]]
  int2237* {.importc: "int22_37", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, array[5, cint]]]]]]

  int22DH* {.importc: "int22_dH", importRna.}: array[nbpairs + 1,
    array[nbpairs + 1, array[5, array[5, array[5, array[5, cint]]]]]]

  mlBase37* {.importc: "ML_BASE37", importRna.}: cint
  mlBasedH* {.importc: "ML_BASEdH", importRna.}: cint
  mlClosing37* {.importc: "ML_closing37", importRna.}: cint
  mlClosingdH* {.importc: "ML_closingdH", importRna.}: cint
  mlIntern37* {.importc: "ML_intern37", importRna.}: cint
  mlInterndH* {.importc: "ML_interndH", importRna.}: cint
  tripleC37* {.importc: "TripleC37", importRna.}: cint
  tripleCdH* {.importc: "TripleCdH", importRna.}: cint
  multipleCA37* {.importc: "MultipleCA37", importRna.}: cint
  multipleCAdH* {.importc: "MultipleCAdH", importRna.}: cint
  multipleCB37* {.importc: "MultipleCB37", importRna.}: cint
  multipleCBdH* {.importc: "MultipleCBdH", importRna.}: cint

  MAX_NINIO* {.importc: "MAX_NINIO", importRna.}: cint

  ninio37* {.importc: "ninio37", importRna.}: cint
  niniodH* {.importc: "niniodH", importRna.}: cint

  terminalAU37* {.importc: "TerminalAU37", importRna.}: cint
  terminalAUdH* {.importc: "TerminalAUdH", importRna.}: cint

  duplexInit37* {.importc: "DuplexInit37", importRna.}: cint
  duplexInitdH* {.importc: "DuplexInitdH", importRna.}: cint

  tetraloops* {.importc: "Tetraloops", importRna.}: ptr char

  tetraloop37* {.importc: "Tetraloop37", importRna.}: ptr cint

  tetraloopdH* {.importc: "TetraloopdH", importRna.}: ptr cint
  triloops* {.importc: "Triloops", importRna.}: ptr char

  triloop37* {.importc: "Triloop37", importRna.}: ptr cint

  triloopdH* {.importc: "TriloopdH", importRna.}: ptr cint

  hexaloops* {.importc: "Hexaloops", importRna.}: ptr char

  hexaloop37* {.importc: "Hexaloop37", importRna.}: ptr cint

  hexaloopdH* {.importc: "HexaloopdH", importRna.}: ptr cint

  gQuadAlpha37* {.importc: "GQuadAlpha37", importRna.}: cint
  gQuadAlphadH* {.importc: "GQuadAlphadH", importRna.}: cint
  gQuadBeta37* {.importc: "GQuadBeta37", importRna.}: cint
  gQuadBetadH* {.importc: "GQuadBetadH", importRna.}: cint
  tmeasure* {.importc: "Tmeasure", importRna.}: cdouble
