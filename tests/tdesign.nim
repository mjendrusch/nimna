import nimna, nimna.design, unittest

suite "Test nucleic acid design behaviour":
  setup:
    const
      target     = "NNNNNNNNATGACNNNNNNNN"
      structure1 = "((((((((...))))..))))"
      structure2 = "((...(((.....)))...))"
      T          = 25.0

  test "Test simple inverse folding":
    proc fitness(c: Compound): float =
      let res = c.mfe
      result = 0.0
      for idx in 0 ..< structure1.len:
        if res.struc[idx] == structure1[idx]:
          result -= 100.0
        else:
          result += 100.0
        result += res.E
    let design = newEngine(20, fitness)
    design.pattern = target
    design.structure = structure1
    design.settings = settings(temperature = T)
    design.mutationProbability = 0.5
    design.consistentMutationProbability = 0.9
    design.step(100)
    check design.best.mfe.struc == structure1
  test "Test optimization of GC content":
    proc fitness(c: Compound): float =
      result = 0.0
      for elem in c.sequence:
        if elem in "GgCc":
          result -= 1.0
      result /= c.sequence.len.float
    let design = newEngine(20, fitness)
    design.pattern = target
    design.step(100)
    check fitness(design.best) == -18.0 / 21.0
  test "Test multi-target folding with consistent mutation":
    proc fitness(c: Compound): float =
      let res = c.mfe
      result = 0.0
      for idx in 0 ..< structure1.len:
        if res.struc[idx] == structure1[idx]:
          result -= 100.0
        else:
          result += 100.0
        if res.struc[idx] == structure2[idx]:
          result -= 10.0
        else:
          result += 10.0
      result += res.E

    let design = newEngine(20, fitness)
    design.pattern = target
    design.addStructure structure1
    design.addStructure structure2
    design.settings = settings(temperature = T)
    design.mutationProbability = 0.8
    design.consistentMutationProbability = 0.5
    design.step(100)
