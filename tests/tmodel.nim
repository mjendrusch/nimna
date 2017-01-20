import ../nimna, unittest

suite "Test model parameter behaviour":

  setup:
    let
      s1 = settings(temperature = 37.0, noGU = 1)
      s2 = settings(temperature = 22.0)

  test "Test update":
    let c = compound"CCCCCAAAGGGGG"
    check c.update(s1).params[].temperature == 37.0
    check c.update(s2).params[].temperature == 22.0
    check c.update(s1.toParams).params[].temperature == 37.0
    check c.update(s2.toScaledParams).expParams[].temperature == 22.0
