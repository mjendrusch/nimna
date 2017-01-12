


type
  VrnaSolTwoD_pfT* = object
    k*: cint
    l*: cint
    q*: Flt_Or_Dbl



proc vrnaPfTwoD*(vc: ptr VrnaFoldCompoundT; maxDistance1: cint; maxDistance2: cint): ptr VrnaSolTwoD_pfT {.
    cdecl, importc: "vrna_pf_TwoD", dynlib: rnaLib.}

proc vrnaPbacktrackTwoD*(vc: ptr VrnaFoldCompoundT; d1: cint; d2: cint): cstring {.cdecl,
    importc: "vrna_pbacktrack_TwoD", dynlib: rnaLib.}

proc vrnaPbacktrack5TwoD*(vc: ptr VrnaFoldCompoundT; d1: cint; d2: cint; length: cuint): cstring {.
    cdecl, importc: "vrna_pbacktrack5_TwoD", dynlib: rnaLib.}

when defined(VRNA_BACKWARD_COMPAT):
  const
    TwoDpfoldSolution* = vrnaSolTwoD_pfT
  type
    TwoDpfoldVars* = object
      alloc*: cuint
      ptype*: cstring
      sequence*: cstring
      s*: ptr cshort
      s1*: ptr cshort
      maxD1*: cuint
      maxD2*: cuint
      temperature*: cdouble
      initTemp*: cdouble
      scale*: ptr Flt_Or_Dbl
      pfScale*: Flt_Or_Dbl
      pfParams*: ptr VrnaExpParamT
      myIindx*: ptr cint
      jindx*: ptr cint
      referencePt1*: ptr cshort
      referencePt2*: ptr cshort
      referenceBPs1*: ptr cuint
      referenceBPs2*: ptr cuint
      bpdist*: ptr cuint
      mm1*: ptr cuint
      mm2*: ptr cuint
      circ*: cint
      dangles*: cint
      seqLength*: cuint
      q*: ptr ptr ptr Flt_Or_Dbl
      q_B*: ptr ptr ptr Flt_Or_Dbl
      q_M*: ptr ptr ptr Flt_Or_Dbl
      q_M1*: ptr ptr ptr Flt_Or_Dbl
      q_M2*: ptr ptr ptr Flt_Or_Dbl
      q_c*: ptr ptr Flt_Or_Dbl
      q_cH*: ptr ptr Flt_Or_Dbl
      q_cI*: ptr ptr Flt_Or_Dbl
      q_cM*: ptr ptr Flt_Or_Dbl
      lMinValues*: ptr ptr cint
      lMaxValues*: ptr ptr cint
      kMinValues*: ptr cint
      kMaxValues*: ptr cint
      lMinValuesB*: ptr ptr cint
      lMaxValuesB*: ptr ptr cint
      kMinValuesB*: ptr cint
      kMaxValuesB*: ptr cint
      lMinValuesM*: ptr ptr cint
      lMaxValuesM*: ptr ptr cint
      kMinValuesM*: ptr cint
      kMaxValuesM*: ptr cint
      lMinValuesM1*: ptr ptr cint
      lMaxValuesM1*: ptr ptr cint
      kMinValuesM1*: ptr cint
      kMaxValuesM1*: ptr cint
      lMinValuesM2*: ptr ptr cint
      lMaxValuesM2*: ptr ptr cint
      kMinValuesM2*: ptr cint
      kMaxValuesM2*: ptr cint
      lMinValuesQc*: ptr cint
      lMaxValuesQc*: ptr cint
      kMinValuesQc*: cint
      kMaxValuesQc*: cint
      lMinValuesQcH*: ptr cint
      lMaxValuesQcH*: ptr cint
      kMinValuesQcH*: cint
      kMaxValuesQcH*: cint
      lMinValuesQcI*: ptr cint
      lMaxValuesQcI*: ptr cint
      kMinValuesQcI*: cint
      kMaxValuesQcI*: cint
      lMinValuesQcM*: ptr cint
      lMaxValuesQcM*: ptr cint
      kMinValuesQcM*: cint
      kMaxValuesQcM*: cint
      q_rem*: ptr Flt_Or_Dbl
      q_B_rem*: ptr Flt_Or_Dbl
      q_M_rem*: ptr Flt_Or_Dbl
      q_M1Rem*: ptr Flt_Or_Dbl
      q_M2Rem*: ptr Flt_Or_Dbl
      q_cRem*: Flt_Or_Dbl
      q_cH_rem*: Flt_Or_Dbl
      q_cI_rem*: Flt_Or_Dbl
      q_cM_rem*: Flt_Or_Dbl
      compatibility*: ptr VrnaFoldCompoundT

  deprecated(twoDpfoldVars *
      getTwoDpfoldVariables(`const`, char * seq, `const`, char * structure1,
                            char * structure2, int, circ))
  deprecated(void, destroyTwoDpfoldVariables(twoDpfoldVars * vars))
  deprecated(twoDpfoldSolution *
      twoDpfoldList(twoDpfoldVars * vars, int, maxDistance1, int, maxDistance2))
  deprecated(char * twoDpfoldPbacktrack(twoDpfoldVars * vars, int, d1, int, d2))
  deprecated(char *
      twoDpfoldPbacktrack5(twoDpfoldVars * vars, int, d1, int, d2, unsigned, int, length))
  deprecated(flt_Or_Dbl *
      twoDpfold(twoDpfoldVars * ourVariables, int, maxDistance1, int, maxDistance2)[])
  deprecated(flt_Or_Dbl *
      twoDpfoldCirc(twoDpfoldVars * ourVariables, int, maxDistance1, int, maxDistance2)[])