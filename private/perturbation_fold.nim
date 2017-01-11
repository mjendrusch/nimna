#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import
  dataStructures


const
  VRNA_OBJECTIVE_FUNCTION_QUADRATIC* = 0


const
  VRNA_OBJECTIVE_FUNCTION_ABSOLUTE* = 1


const
  VRNA_MINIMIZER_DEFAULT* = 0


const
  VRNA_MINIMIZER_CONJUGATE_FR* = 1


const
  VRNA_MINIMIZER_CONJUGATE_PR* = 2


const
  VRNA_MINIMIZER_VECTOR_BFGS* = 3


const
  VRNA_MINIMIZER_VECTOR_BFGS2* = 4


const
  VRNA_MINIMIZER_STEEPEST_DESCENT* = 5


type
  ProgressCallback* = proc (iteration: cint; score: cdouble; epsilon: ptr cdouble) {.cdecl.}


proc vrnaScMinimizePertubation*(vc: ptr VrnaFoldCompoundT;
                               qProbUnpaired: ptr cdouble; objectiveFunction: cint;
                               sigmaSquared: cdouble; tauSquared: cdouble;
                               algorithm: cint; sampleSize: cint;
                               epsilon: ptr cdouble; initialStepSize: cdouble;
                               minStepSize: cdouble; minImprovement: cdouble;
                               minimizerTolerance: cdouble;
                               callback: ProgressCallback) {.cdecl,
    importc: "vrna_sc_minimize_pertubation", dynlib: rnaLib.}