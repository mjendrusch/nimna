import ../nimna.nim, unittest

suite "Test folding behaviour":

  setup:
    let
      comp = compound"GGGGGGAAACCCCCC"
      dim = dimer("GGGGGG", "CCCCCC")

  test "Test mfe folding":
    let
      (energy, structure) = comp.mfe
      (dimEnergy, dimStructure) = dim.mfeDimer
    check energy < 0.0 and dimEnergy < 0.0
    check structure == "((((((...))))))"
    check dimStructure == "(((((())))))"

  test "Test pf folding":
    let
      (energy, structure) = comp.pf
      (dimEnergies, dimStructure) = dim.pfDimer
    check energy < 0.0 and dimEnergies.f0ab < 0.0
    check structure == "((((((...))))))"
    check dimStructure == "(((((())))))"

  test "Test mea folding":
    let
      (energy, structure) = comp.mea
    check energy < 0.0
    check structure == "((((((...))))))"

  test "Test centroid folding":
    let
      (distance, structure) = comp.centroid
    check distance >= 0.0
    check structure == "((((((...))))))"
