


type
  VrnaSolTwoD_t* = object
    k*: cint
    l*: cint
    en*: cfloat
    s*: cstring



proc vrnaMfeTwoD*(vc: ptr VrnaFoldCompoundT; distance1: cint; distance2: cint): ptr VrnaSolTwoD_t {.
    cdecl, importc: "vrna_mfe_TwoD", dynlib: rnaLib.}

proc vrnaBacktrack5TwoD*(vc: ptr VrnaFoldCompoundT; k: cint; l: cint; j: cuint): cstring {.
    cdecl, importc: "vrna_backtrack5_TwoD", dynlib: rnaLib.}
when defined(VRNA_BACKWARD_COMPAT):
  const
    TwoDfoldSolution* = vrnaSolTwoD_t
  type
    TwoDfoldVars* = object
      p*: ptr VrnaParamT
      doBacktrack*: cint
      ptype*: cstring
      sequence*: cstring
      s*: ptr cshort
      s1*: ptr cshort
      maxD1*: cuint
      maxD2*: cuint
      mm1*: ptr cuint
      mm2*: ptr cuint
      myIindx*: ptr cint
      temperature*: cdouble
      referenceBPs1*: ptr cuint
      referenceBPs2*: ptr cuint
      bpdist*: ptr cuint
      referencePt1*: ptr cshort
      referencePt2*: ptr cshort
      circ*: cint
      dangles*: cint
      seqLength*: cuint
      e_F5*: ptr ptr ptr cint
      e_F3*: ptr ptr ptr cint
      e_C*: ptr ptr ptr cint
      e_M*: ptr ptr ptr cint
      e_M1*: ptr ptr ptr cint
      e_M2*: ptr ptr ptr cint
      e_Fc*: ptr ptr cint
      e_FcH*: ptr ptr cint
      e_FcI*: ptr ptr cint
      e_FcM*: ptr ptr cint
      lMinValues*: ptr ptr cint
      lMaxValues*: ptr ptr cint
      kMinValues*: ptr cint
      kMaxValues*: ptr cint
      lMinValuesM*: ptr ptr cint
      lMaxValuesM*: ptr ptr cint
      kMinValuesM*: ptr cint
      kMaxValuesM*: ptr cint
      lMinValuesM1*: ptr ptr cint
      lMaxValuesM1*: ptr ptr cint
      kMinValuesM1*: ptr cint
      kMaxValuesM1*: ptr cint
      lMinValuesF*: ptr ptr cint
      lMaxValuesF*: ptr ptr cint
      kMinValuesF*: ptr cint
      kMaxValuesF*: ptr cint
      lMinValuesF3*: ptr ptr cint
      lMaxValuesF3*: ptr ptr cint
      kMinValuesF3*: ptr cint
      kMaxValuesF3*: ptr cint
      lMinValuesM2*: ptr ptr cint
      lMaxValuesM2*: ptr ptr cint
      kMinValuesM2*: ptr cint
      kMaxValuesM2*: ptr cint
      lMinValuesFc*: ptr cint
      lMaxValuesFc*: ptr cint
      kMinValuesFc*: cint
      kMaxValuesFc*: cint
      lMinValuesFcH*: ptr cint
      lMaxValuesFcH*: ptr cint
      kMinValuesFcH*: cint
      kMaxValuesFcH*: cint
      lMinValuesFcI*: ptr cint
      lMaxValuesFcI*: ptr cint
      kMinValuesFcI*: cint
      kMaxValuesFcI*: cint
      lMinValuesFcM*: ptr cint
      lMaxValuesFcM*: ptr cint
      kMinValuesFcM*: cint
      kMaxValuesFcM*: cint
      e_F5Rem*: ptr cint
      e_F3Rem*: ptr cint
      e_C_rem*: ptr cint
      e_M_rem*: ptr cint
      e_M1Rem*: ptr cint
      e_M2Rem*: ptr cint
      e_FcRem*: cint
      e_FcH_rem*: cint
      e_FcI_rem*: cint
      e_FcM_rem*: cint
      when defined(COUNT_STATES):
        var N_F5* {.importc: "N_F5", dynlib: rnaLib.}: ptr ptr ptr culong
        var N_C* {.importc: "N_C", dynlib: rnaLib.}: ptr ptr ptr culong
        var N_M* {.importc: "N_M", dynlib: rnaLib.}: ptr ptr ptr culong
        var N_M1* {.importc: "N_M1", dynlib: rnaLib.}: ptr ptr ptr culong
      compatibility*: ptr VrnaFoldCompoundT

  deprecated(twoDfoldVars *
      getTwoDfoldVariables(`const`, char * seq, `const`, char * structure1, `const`,
                           char * structure2, int, circ))
  deprecated(void, destroyTwoDfoldVariables(twoDfoldVars * ourVariables))
  deprecated(twoDfoldSolution *
      twoDfoldList(twoDfoldVars * vars, int, distance1, int, distance2))
  deprecated(char *
      twoDfoldBacktrackF5(unsigned, int, j, int, k, int, l, twoDfoldVars * vars))
  deprecated(twoDfoldSolution *
      twoDfold(twoDfoldVars * ourVariables, int, distance1, int, distance2)[])
