#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

type
  Compound* = ref object of RootObj
    ## Represents a sequence of DNA or RNA together with folding parameters
    ## and results.
    vfc: ptr VrnaFoldCompoundT
    hasPf: bool
    isD: bool
  Compound2D* = ref object of Compound
    ## Represents a sequence of DNA or RNA together with folding parameters
    ## folding results, and a pair of reference structures.
  CompoundComparative* = ref object of Compound
    ## Represents a sequence alignment of DNAs or RNAs with folding parameters
    ## and results.
  Alignment* = ref object
    algn: cStringArray
    names: cStringArray
    id: cstring
    structure: cstring
    nSeqs: int
  MfeSolution* = VrnaSolTwoDT
    ## Represents a secondary structure and energy at a single position in
    ## secondary structure space.
  PfSolution* = VrnaSolTwoDPfT
    ## Represents a partition function at a single position in
    ## secondary structure space.
  MfeSolutions* = ref object
    mfe: ptr MfeSolution
  PfSolutions* = ref object
    pf: ptr PfSolution
  InteractionList* = ref object of RootObj
    ## Represents a list of base interactions.
    pl: ptr VrnaPlistT
    len: int
  PairList* = ref object of InteractionList
    ## Represents a list of base pairing interactions
  GQuadList* = ref object of InteractionList
    ## Represents a list of G-quadruplex interactions.
  PairListItem* = VrnaPlistT
  Settings* {. byref .} = VrnaMdT
    ## Represents a set of conditions for folding, such as for example
    ## temperature.
  Parameters* {. byref .} = VrnaParamT
    ## Represents a set of folding parameters, computed from Settings.
  ScaledParameters* {. byref .} = VrnaExpParamT
    ## Represents a set of partition function folding parameters,
    ## computed from Settings.
  ConstraintOption* = distinct cuint
    ## Represents the way a constraint on folding is stored and interpreted.
  UnstructuredOption* = distinct cuint
    ## Represents the kinds of motifs a ligand can bind to,
  Probabilities* = ref object
    ## Represents the base pair probability matrix of a Compound
    parent: Compound
    bppm: ptr FltOrDbl
  MotifError* = object of Exception

const
  vcNoHeader* = VRNA_CONSTRAINT_NO_HEADER.ConstraintOption
  vcDb* = VRNA_CONSTRAINT_DB.ConstraintOption
  vcdbEnforceBp* = VRNA_CONSTRAINT_DB_ENFORCE_BP.ConstraintOption
  vcdbPipe* = VRNA_CONSTRAINT_DB_PIPE.ConstraintOption
  vcdbDot* = VRNA_CONSTRAINT_DB_DOT.ConstraintOption
  vcdbX* = VRNA_CONSTRAINT_DB_X.ConstraintOption
  vcdbAngBrack* = VRNA_CONSTRAINT_DB_ANG_BRACK.ConstraintOption
  vcdbRndBrack* = VRNA_CONSTRAINT_DB_RND_BRACK.ConstraintOption
  vcdbIntramol* = VRNA_CONSTRAINT_DB_INTRAMOL.ConstraintOption
  vcdbIntermol* = VRNA_CONSTRAINT_DB_INTERMOL.ConstraintOption
  vcdbGquad* = VRNA_CONSTRAINT_DB_GQUAD.ConstraintOption
  vcdbDefault* = VRNA_CONSTRAINT_DB_DEFAULT.ConstraintOption
  vccExtLoop* = VRNA_CONSTRAINT_CONTEXT_EXT_LOOP.ConstraintOption
  vccHpLoop* = VRNA_CONSTRAINT_CONTEXT_HP_LOOP.ConstraintOption
  vccIntLoop* = VRNA_CONSTRAINT_CONTEXT_INT_LOOP.ConstraintOption
  vccIntLoopEnc* = VRNA_CONSTRAINT_CONTEXT_INT_LOOP_ENC.ConstraintOption
  vccMbLoop* = VRNA_CONSTRAINT_CONTEXT_MB_LOOP.ConstraintOption
  vccMbLoopEnc* = VRNA_CONSTRAINT_CONTEXT_MB_LOOP_ENC.ConstraintOption
  vccEnforce* = VRNA_CONSTRAINT_CONTEXT_ENFORCE.ConstraintOption
  vccNoRemove* = VRNA_CONSTRAINT_CONTEXT_NO_REMOVE.ConstraintOption
  vccAllLoops* = VRNA_CONSTRAINT_CONTEXT_ALL_LOOPS.ConstraintOption
  vcmDefault* = VRNA_OPTION_DEFAULT.ConstraintOption
