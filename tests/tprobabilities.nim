import ../nimna, unittest

suite "Test probability view behaviour":

  setup:
    let
      sequence = "GGGGGAAACCCCC"
      comp = compound sequence
      prob = comp.probabilities

  test "Test probability accessors":
    expect IndexError:
      discard prob[-1, 5]
    expect IndexError:
      discard prob[5, -1]
    expect IndexError:
      discard prob[-1, -1]
    expect IndexError:
      discard prob[0, sequence.len]
    expect IndexError:
      discard prob[sequence.len, 0]
    expect IndexError:
      discard prob[sequence.len, sequence.len]
    for idx in 0 ..< sequence.len - 1:
      check prob[idx, idx + 1] < 1e-6
    for idx in 0 ..< (sequence.len - 3) div 2:
      check prob[idx, idx + 1] > 1e-3
    for idx in 0 ..< sequence.len:
      for idy in idx + 1 ..< sequence.len:
        check prob[idx, idy] == prob[idy, idx]

  test "Test iterators":
    for item in prob.items:
      check 0.0 <= item and item <= 1.0
    for pos, val in prob.pairs:
      check 0.0 <= val and val <= 1.0
      check pos.i < sequence.len and -1 < pos.i
      check pos.j < sequence.len and -1 < pos.j
    for i, j, val in prob.triples:
      check 0.0 <= val and val <= 1.0
      check i < sequence.len and -1 < i
      check j < sequence.len and -1 < j
    for column in prob.positions:
      for val in column:
        check 0.0 <= val and val <= 1.0
