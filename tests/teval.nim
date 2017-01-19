import ../nimna.nim, unittest

suite "Test energy evaluation behaviour":

  setup:
    let comp = compound"GGGGGGAAACCCCCC"

  test "Test eval":
    let
      (energy, structure) = comp.mfe
    check energy - 1e-5 < comp.eval(structure) and
      comp.eval(structure) < energy + 1e-5

  test "Test eval move":
    check comp.evalAdd(".(((((...))))).", 0, 14) < 0.0
    check comp.evalRemove("((((((...))))))", 0, 14) > 0.0
