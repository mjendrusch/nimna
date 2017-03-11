import ../nimna, unittest

suite "Test Compound behaviour":

  setup:
    let
      c1 = compound"GGGGGAAACCCCC"
      cs1 = compound("GGGGGAAACCCCC", settings(temperature = 22.0, uniqML = 1))
      c2 = compound"GGGGGA&ACCCCC"
      c3 = dimer("GGGGGA", "ACCCCC")
      c4 = compound(["GGGGGG", "GGGCGG", "GGAGGG"])
      c5 = compound2D("GGGGGAAACCCCC", "(((((...)))))", "..(((...)))..")

  test "Compound types":
    check c1.typ == VrnaFcTypeSingle
    check c2.typ == VrnaFcTypeSingle
    check c3.typ == VrnaFcTypeSingle
    check c4.typ == VrnaFcTypeComparative
    check c5.typ == VrnaFcTypeSingle
    check(not c1.isDimer)
    check c2.isDimer
    check c3.isDimer
    check c2.sequence == c3.sequence
    check c4 is CompoundComparative
    check c5 is Compound2D

  test "Compound accessors":
    check c1.sequence == "GGGGGAAACCCCC"
    check c1.len == "GGGGGAAACCCCC".len
    check cs1.params[].temperature == 22.0
