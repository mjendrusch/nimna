#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.


when defined(USE_FLOAT_PF):
  type
    Flt_Or_Dbl* = cfloat
else:
  type
    Flt_Or_Dbl* = cdouble

type
  VrnaCallbackFreeAuxdata* = proc (data: pointer) {.cdecl.}
  VrnaCallbackRecursionStatus* = proc (status: cuchar; data: pointer) {.cdecl.}

const
  VRNA_STATUS_MFE_PRE* = cuchar(1)
  VRNA_STATUS_MFE_POST* = cuchar(2)
  VRNA_STATUS_PF_PRE* = cuchar(3)
  VRNA_STATUS_PF_POST* = cuchar(4)
  VRNA_PLIST_TYPE_BASEPAIR* = 0
  VRNA_PLIST_TYPE_GQUAD* = 1
  VRNA_PLIST_TYPE_H_MOTIF* = 2
  VRNA_PLIST_TYPE_I_MOTIF* = 3
  VRNA_PLIST_TYPE_UD_MOTIF* = 4
  # VRNA_BACKWARD_COMPAT* = true

const
  VRNA_GQUAD_MAX_STACK_SIZE* = 7
  VRNA_GQUAD_MIN_STACK_SIZE* = 2
  VRNA_GQUAD_MAX_LINKER_LENGTH* = 15
  VRNA_GQUAD_MIN_LINKER_LENGTH* = 1
  VRNA_GQUAD_MIN_BOX_SIZE* = (
    (4 * VRNA_Gquad_Min_Stack_Size) + (3 * Vrna_Gquad_Min_Linker_Length))
  VRNA_GQUAD_MAX_BOX_SIZE* = (
    (4 * Vrna_Gquad_Max_Stack_Size) + (3 * Vrna_Gquad_Max_Linker_Length))

const
  nbpairs: int = 7
  maxLoop: int = 30
# import
#   viennaRNA/structuredDomains, viennaRNA/unstructuredDomains

type
  VrnaParamS* = object
    id*: cint
    stack*: array[nbpairs + 1, array[nbpairs + 1, cint]]
    hairpin*: array[31, cint]
    bulge*: array[maxloop + 1, cint]
    internalLoop*: array[maxloop + 1, cint]
    mismatchExt*: array[nbpairs + 1, array[5, array[5, cint]]]
    mismatchI*: array[nbpairs + 1, array[5, array[5, cint]]]
    mismatch1nI*: array[nbpairs + 1, array[5, array[5, cint]]]
    mismatch23I*: array[nbpairs + 1, array[5, array[5, cint]]]
    mismatchH*: array[nbpairs + 1, array[5, array[5, cint]]]
    mismatchM*: array[nbpairs + 1, array[5, array[5, cint]]]
    dangle5*: array[nbpairs + 1, array[5, cint]]
    dangle3*: array[nbpairs + 1, array[5, cint]]
    int11*: array[nbpairs + 1, array[nbpairs + 1, array[5, array[5, cint]]]]
    int21*: array[nbpairs + 1,
                 array[nbpairs + 1, array[5, array[5, array[5, cint]]]]]
    int22*: array[nbpairs + 1, array[nbpairs + 1,
                                 array[5, array[5, array[5, array[5, cint]]]]]]
    ninio*: array[5, cint]
    lxc*: cdouble
    mLbase*: cint
    mLintern*: array[nbpairs + 1, cint]
    mLclosing*: cint
    terminalAU*: cint
    duplexInit*: cint
    tetraloopE*: array[200, cint]
    tetraloops*: array[1401, char]
    triloopE*: array[40, cint]
    triloops*: array[241, char]
    hexaloopE*: array[40, cint]
    hexaloops*: array[1801, char]
    tripleC*: cint
    multipleCA*: cint
    multipleCB*: cint
    gquad*: array[Vrna_Gquad_Max_Stack_Size + 1,
                 array[3 * Vrna_Gquad_Max_Linker_Length + 1, cint]]
    temperature*: cdouble
    modelDetails*: VrnaMdT

  VrnaParamT* = VrnaParamS

  VrnaExpParamS* = object
    id*: cint
    expstack*: array[nbpairs + 1, array[nbpairs + 1, cdouble]]
    exphairpin*: array[31, cdouble]
    expbulge*: array[maxloop + 1, cdouble]
    expinternal*: array[maxloop + 1, cdouble]
    expmismatchExt*: array[nbpairs + 1, array[5, array[5, cdouble]]]
    expmismatchI*: array[nbpairs + 1, array[5, array[5, cdouble]]]
    expmismatch23I*: array[nbpairs + 1, array[5, array[5, cdouble]]]
    expmismatch1nI*: array[nbpairs + 1, array[5, array[5, cdouble]]]
    expmismatchH*: array[nbpairs + 1, array[5, array[5, cdouble]]]
    expmismatchM*: array[nbpairs + 1, array[5, array[5, cdouble]]]
    expdangle5*: array[nbpairs + 1, array[5, cdouble]]
    expdangle3*: array[nbpairs + 1, array[5, cdouble]]
    expint11*: array[nbpairs + 1, array[nbpairs + 1, array[5, array[5, cdouble]]]]
    expint21*: array[nbpairs + 1,
                    array[nbpairs + 1, array[5, array[5, array[5, cdouble]]]]]
    expint22*: array[nbpairs + 1, array[nbpairs + 1, array[5,
        array[5, array[5, array[5, cdouble]]]]]]
    expninio*: array[5, array[maxloop + 1, cdouble]]
    lxc*: cdouble
    expMLbase*: cdouble
    expMLintern*: array[nbpairs + 1, cdouble]
    expMLclosing*: cdouble
    expTermAU*: cdouble
    expDuplexInit*: cdouble
    exptetra*: array[40, cdouble]
    exptri*: array[40, cdouble]
    exphex*: array[40, cdouble]
    tetraloops*: array[1401, char]
    expTriloop*: array[40, cdouble]
    triloops*: array[241, char]
    hexaloops*: array[1801, char]
    expTripleC*: cdouble
    expMultipleCA*: cdouble
    expMultipleCB*: cdouble
    expgquad*: array[Vrna_Gquad_Max_Stack_Size + 1,
                    array[3 * Vrna_Gquad_Max_Linker_Length + 1, cdouble]]
    kT*: cdouble
    pfScale*: cdouble
    temperature*: cdouble
    alpha*: cdouble
    modelDetails*: VrnaMdT

  VrnaExpParamT* = VrnaExpParamS
  VrnaHcT* = VrnaHcS
  VrnaHcUpT* = VrnaHcUpS
  VrnaCallbackHcEvaluate* = proc (i: cint; j: cint; k: cint; l: cint; d: char; data: pointer): char {.
      cdecl.}
  VrnaHcS* = object
    matrix*: cstring
    upExt*: ptr cint
    upHp*: ptr cint
    upInt*: ptr cint
    upMl*: ptr cint
    f*: ptr VrnaCallbackHcEvaluate
    data*: pointer
    freeData*: ptr VrnaCallbackFreeAuxdata
  VrnaHcUpS* = object
    position*: cint
    options*: char

  VrnaBasepairS* = object
    i*: cint
    j*: cint

  VrnaPlistS* = object
    i*: cint
    j*: cint
    p*: cfloat
    `type`*: cint

  VrnaCpairS* = object
    i*: cint
    j*: cint
    mfe*: cint
    p*: cfloat
    hue*: cfloat
    sat*: cfloat

  VrnaColorS* = object
    hue*: cfloat
    sat*: cfloat
    bri*: cfloat

  VrnaDataLinearS* = object
    position*: cuint
    value*: cfloat
    color*: VrnaColorS

  VrnaSectS* = object
    i*: cint
    j*: cint
    ml*: cint

  VrnaBpStackS* = object
    i*: cuint
    j*: cuint

  PuContrib* = object
    h*: ptr ptr cdouble
    i*: ptr ptr cdouble
    m*: ptr ptr cdouble
    e*: ptr ptr cdouble
    length*: cint
    w*: cint

  interact* = object
    pi*: ptr cdouble
    gi*: ptr cdouble
    gikjl*: cdouble
    gikjlWo*: cdouble
    i*: cint
    k*: cint
    j*: cint
    l*: cint
    length*: cint

  PuOut* = object
    len*: cint
    uVals*: cint
    contribs*: cint
    header*: cstringArray
    uValues*: ptr ptr cdouble

  Constrain* = object
    indx*: ptr cint
    ptype*: cstring

  DuplexT* = object
    i*: cint
    j*: cint
    `end`*: cint
    structure*: cstring
    energy*: cdouble
    energyBacktrack*: cdouble
    openingBacktrackX*: cdouble
    openingBacktrackY*: cdouble
    offset*: cint
    dG1*: cdouble
    dG2*: cdouble
    ddG*: cdouble
    tb*: cint
    te*: cint
    qb*: cint
    qe*: cint

  Folden* = object
    k*: cint
    energy*: cint
    next*: pointer#ptr Node

  SnoopT* = object
    i*: cint
    j*: cint
    u*: cint
    structure*: cstring
    energy*: cfloat
    duplexEl*: cfloat
    duplexEr*: cfloat
    loopE*: cfloat
    loopD*: cfloat
    pscd*: cfloat
    psct*: cfloat
    pscg*: cfloat
    duplexOl*: cfloat
    duplexOr*: cfloat
    duplexOt*: cfloat
    fullStemEnergy*: cfloat

  DupVar* = object
    i*: cint
    j*: cint
    `end`*: cint
    pkHelix*: cstring
    structure*: cstring
    energy*: cdouble
    offset*: cint
    dG1*: cdouble
    dG2*: cdouble
    ddG*: cdouble
    tb*: cint
    te*: cint
    qb*: cint
    qe*: cint
    inactive*: cint
    processed*: cint

  VrnaFcTypeE* {.size: sizeof(cint).} = enum
    VRNA_FC_TYPE_SINGLE, VRNA_FC_TYPE_COMPARATIVE

  VrnaFcS* = object
    `type`*: VrnaFcTypeE
    length*: cuint
    cutpoint*: cint
    hc*: ptr VrnaHcT
    matrices*: ptr VrnaMxMfeT
    expMatrices*: ptr VrnaMxPfT
    params*: ptr VrnaParamT
    expParams*: ptr VrnaExpParamT
    iindx*: ptr cint
    jindx*: ptr cint
    statCb*: ptr VrnaCallbackRecursionStatus
    auxdata*: pointer
    freeAuxdata*: ptr VrnaCallbackFreeAuxdata
    domainsStruc*: pointer#ptr VrnaSdT
    domainsUp*: pointer#ptr VrnaUdT
    auxGrammar*: pointer#ptr VrnaGrAuxT
    sequence*: cstring
    sequenceEncoding*: ptr cshort
    sequenceEncoding2*: ptr cshort
    ptype*: cstring
    ptypePfCompat*: cstring
    sc*: pointer#ptr VrnaScT
    sequences*: cstringArray
    nSeq*: cuint
    consSeq*: cstring
    s_cons*: ptr cshort
    s*: ptr ptr cshort
    s5*: ptr ptr cshort
    s3*: ptr ptr cshort
    ss*: cstringArray
    a2s*: ptr ptr cushort
    pscore*: ptr cint
    pscorePfCompat*: ptr cshort
    scs*: ptr pointer#ptr VrnaScT
    oldAliEn*: cint
    maxD1*: cuint
    maxD2*: cuint
    referencePt1*: ptr cshort
    referencePt2*: ptr cshort
    referenceBPs1*: ptr cuint
    referenceBPs2*: ptr cuint
    bpdist*: ptr cuint
    mm1*: ptr cuint
    mm2*: ptr cuint
    windowSize*: cint
    ptypeLocal*: cstringArray

  VrnaMxMfeT* = MxMfeS

  VrnaMxPfT* = MxPfS

  MxTypeE* {.size: sizeof(cint).} = enum
    VRNA_MX_DEFAULT, VRNA_MX_WINDOW, VRNA_MX_2DFOLD

  MfeDefaultInner* = object
    c*: ptr cint
    f5*: ptr cint
    f3*: ptr cint
    fc*: ptr cint
    fML*: ptr cint
    fM1*: ptr cint
    fM2*: ptr cint
    ggg*: ptr cint
    Fc*: cint
    FcH*: cint
    FcI*: cint
    FcM*: cint

  MfeWindowInner* = object
    cLocal*: ptr ptr cint
    f3Local*: ptr cint
    fML_local*: ptr ptr cint
    gggLocal*: ptr ptr cint

  Mfe2DFoldInner* = object
    e_F5*: ptr ptr ptr cint
    lMinF5*: ptr ptr cint
    lMaxF5*: ptr ptr cint
    kMinF5*: ptr cint
    kMaxF5*: ptr cint
    e_F3*: ptr ptr ptr cint
    lMinF3*: ptr ptr cint
    lMaxF3*: ptr ptr cint
    kMinF3*: ptr cint
    kMaxF3*: ptr cint
    e_C*: ptr ptr ptr cint
    lMinC*: ptr ptr cint
    lMaxC*: ptr ptr cint
    kMinC*: ptr cint
    kMaxC*: ptr cint
    e_M*: ptr ptr ptr cint
    lMinM*: ptr ptr cint
    lMaxM*: ptr ptr cint
    kMinM*: ptr cint
    kMaxM*: ptr cint
    e_M1*: ptr ptr ptr cint
    lMinM1*: ptr ptr cint
    lMaxM1*: ptr ptr cint
    kMinM1*: ptr cint
    kMaxM1*: ptr cint
    e_M2*: ptr ptr ptr cint
    lMinM2*: ptr ptr cint
    lMaxM2*: ptr ptr cint
    kMinM2*: ptr cint
    kMaxM2*: ptr cint
    e_Fc*: ptr ptr cint
    lMinFc*: ptr cint
    lMaxFc*: ptr cint
    kMinFc*: cint
    kMaxFc*: cint
    e_FcH*: ptr ptr cint
    lMinFcH*: ptr cint
    lMaxFcH*: ptr cint
    kMinFcH*: cint
    kMaxFcH*: cint
    e_FcI*: ptr ptr cint
    lMinFcI*: ptr cint
    lMaxFcI*: ptr cint
    kMinFcI*: cint
    kMaxFcI*: cint
    e_FcM*: ptr ptr cint
    lMinFcM*: ptr cint
    lMaxFcM*: ptr cint
    kMinFcM*: cint
    kMaxFcM*: cint
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
    n_F5*: ptr ptr ptr culong
    n_C*: ptr ptr ptr culong
    n_M*: ptr ptr ptr culong
    n_M1*: ptr ptr ptr culong

  MfeUnion* = object {.union.}
    default*: MfeDefaultInner
    window*: MfeWindowInner
    fold2d*: Mfe2DFoldInner

  MxMfeS* = object
    `type`*: MxTypeE
    length*: cuint
    union*: MfeUnion

  PfUnion* = object {.union.}
    default*: PfDefaultInner
    fold2d*: Pf2DFoldInner

  MxPfS* = object
    `type`*: MxTypeE
    length*: cuint
    scale*: ptr Flt_Or_Dbl
    expMLbase*: ptr Flt_Or_Dbl
    union*: PfUnion

  PfDefaultInner* = object
    q*: ptr Flt_Or_Dbl
    qb*: ptr Flt_Or_Dbl
    qm*: ptr Flt_Or_Dbl
    qm1*: ptr Flt_Or_Dbl
    probs*: ptr Flt_Or_Dbl
    q1k*: ptr Flt_Or_Dbl
    qln*: ptr Flt_Or_Dbl
    g*: ptr Flt_Or_Dbl
    qo*: Flt_Or_Dbl
    qm2*: ptr Flt_Or_Dbl
    qho*: Flt_Or_Dbl
    qio*: Flt_Or_Dbl
    qmo*: Flt_Or_Dbl

  Pf2DFoldInner* = object
    q*: ptr ptr ptr Flt_Or_Dbl
    lMinQ*: ptr ptr cint
    lMaxQ*: ptr ptr cint
    kMinQ*: ptr cint
    kMaxQ*: ptr cint
    q_B*: ptr ptr ptr Flt_Or_Dbl
    lMinQ_B*: ptr ptr cint
    lMaxQ_B*: ptr ptr cint
    kMinQ_B*: ptr cint
    kMaxQ_B*: ptr cint
    q_M*: ptr ptr ptr Flt_Or_Dbl
    lMinQ_M*: ptr ptr cint
    lMaxQ_M*: ptr ptr cint
    kMinQ_M*: ptr cint
    kMaxQ_M*: ptr cint
    q_M1*: ptr ptr ptr Flt_Or_Dbl
    lMinQ_M1*: ptr ptr cint
    lMaxQ_M1*: ptr ptr cint
    kMinQ_M1*: ptr cint
    kMaxQ_M1*: ptr cint
    q_M2*: ptr ptr ptr Flt_Or_Dbl
    lMinQ_M2*: ptr ptr cint
    lMaxQ_M2*: ptr ptr cint
    kMinQ_M2*: ptr cint
    kMaxQ_M2*: ptr cint
    q_c*: ptr ptr Flt_Or_Dbl
    lMinQ_c*: ptr cint
    lMaxQ_c*: ptr cint
    kMinQ_c*: cint
    kMaxQ_c*: cint
    q_cH*: ptr ptr Flt_Or_Dbl
    lMinQ_cH*: ptr cint
    lMaxQ_cH*: ptr cint
    kMinQ_cH*: cint
    kMaxQ_cH*: cint
    q_cI*: ptr ptr Flt_Or_Dbl
    lMinQ_cI*: ptr cint
    lMaxQ_cI*: ptr cint
    kMinQ_cI*: cint
    kMaxQ_cI*: cint
    q_cM*: ptr ptr Flt_Or_Dbl
    lMinQ_cM*: ptr cint
    lMaxQ_cM*: ptr cint
    kMinQ_cM*: cint
    kMaxQ_cM*: cint
    q_rem*: ptr Flt_Or_Dbl
    q_B_rem*: ptr Flt_Or_Dbl
    q_M_rem*: ptr Flt_Or_Dbl
    q_M1Rem*: ptr Flt_Or_Dbl
    q_M2Rem*: ptr Flt_Or_Dbl
    q_cRem*: Flt_Or_Dbl
    q_cH_rem*: Flt_Or_Dbl
    q_cI_rem*: Flt_Or_Dbl
    q_cM_rem*: Flt_Or_Dbl

  VrnaFoldCompoundT* = VrnaFcS
  VrnaBasepairT* = VrnaBasepairS
  VrnaPlistT* = VrnaPlistS
  VrnaBpStackT* = VrnaBpStackS
  VrnaCpairT* = VrnaCpairS
  VrnaSectT* = VrnaSectS
  VrnaDataLinT* = VrnaDataLinearS
  VrnaColorT* = VrnaColorS

const
  VRNA_OPTION_DEFAULT* = 0
  VRNA_OPTION_MFE* = 1
  VRNA_OPTION_PF* = 2
  VRNA_OPTION_HYBRID* = 4
  VRNA_OPTION_EVAL_ONLY* = 8
  VRNA_OPTION_WINDOW* = 16

proc foldCompound*(sequence: cstring; mdP: ptr VrnaMdT; options: cuint): ptr VrnaFoldCompoundT {.
                   cdecl, importc: "vrna_fold_compound", dynlib: rnaLib.}

proc foldCompoundComparative*(sequences: cstringArray; mdP: ptr VrnaMdT;
                              options: cuint): ptr VrnaFoldCompoundT {.cdecl,
    importc: "vrna_fold_compound_comparative", dynlib: rnaLib.}
proc foldCompoundTwoD*(sequence: cstring; s1: cstring; s2: cstring;
                       mdP: ptr VrnaMdT; options: cuint): ptr VrnaFoldCompoundT {.
    cdecl, importc: "vrna_fold_compound_TwoD", dynlib: rnaLib.}
proc foldCompoundPrepare*(vc: ptr VrnaFoldCompoundT; options: cuint): cint {.cdecl,
    importc: "vrna_fold_compound_prepare", dynlib: rnaLib.}

proc foldCompoundFree*(vc: ptr VrnaFoldCompoundT) {.cdecl,
    importc: "vrna_fold_compound_free", dynlib: rnaLib.}

proc foldCompoundAddAuxdata*(vc: ptr VrnaFoldCompoundT; data: pointer;
                                f: ptr VrnaCallbackFreeAuxdata) {.cdecl,
    importc: "vrna_fold_compound_add_auxdata", dynlib: rnaLib.}

proc foldCompoundAddCallback*(vc: ptr VrnaFoldCompoundT;
                                 f: ptr VrnaCallbackRecursionStatus) {.cdecl,
    importc: "vrna_fold_compound_add_callback", dynlib: rnaLib.}
