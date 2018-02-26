#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

proc vrnaPairingProbs*(vc: ptr VrnaFoldCompoundT; structure: cstring) {.cdecl,
    importc: "vrna_pairing_probs", importRna.}

proc vrnaMeanBpDistancePr*(length: cint; pr: ptr Flt_Or_Dbl): cdouble {.cdecl,
    importc: "vrna_mean_bp_distance_pr", importRna.}

proc vrnaMeanBpDistance*(vc: ptr VrnaFoldCompoundT): cdouble {.cdecl,
    importc: "vrna_mean_bp_distance", importRna.}

proc vrnaStackProb*(vc: ptr VrnaFoldCompoundT; cutoff: cdouble): ptr VrnaPlistT {.cdecl,
    importc: "vrna_stack_prob", importRna.}
