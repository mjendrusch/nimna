import ../nimna, unittest

suite "Test Alignment behaviour":

  setup:
    let
      inputSequences = ["GGGG", "GGAG", "GGCG"]
      inputNames = ["wt", "with_a", "with_c"]
      algn = alignment(inputSequences, inputNames)

  test "Test accessors":
    check algn.sequence(0) == "GGGG"
    check algn.name(1) == "with_a"
    check algn.len == 3
    expect AssertionError:
      discard algn.name(3)
    expect AssertionError:
      discard algn.sequence(3)
    expect AssertionError:
      discard algn.name(-1)
    expect AssertionError:
      discard algn.sequence(-1)

  test "Test iterators":
    for name in algn.names:
      check name in inputNames
    for sequence in algn.sequences:
      check sequence in inputSequences
    var idx = 0
    for name, sequence in algn.pairs:
      check inputNames[idx] == name
      check inputSequences[idx] == sequence
      inc idx
