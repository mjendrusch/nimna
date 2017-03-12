# nimna
DNA/RNA folding in Nim
## What is nimna?
**nimna** is a set of bindings to ViennaRNA, a library for RNA and DNA folding applications.
It consists of a very thin wrapper `RNA.nim`, as well as a high level interface `nimna.nim`,
which wraps the many pointers used in the ViennaRNA into garbage collected `ref objects` to
make the library easier to use.
## What can I do with it?
Currently, **nimna** is very experimental and a *work in progress*. Thus, the currently
available functionality in the high level interface is quite limited, but will be steadily
growing. You can find more documentation [here](https://mjendrusch.github.io/nimna)

Currently, the following things are available with the high level interface:

  * Folding:
    * Partition function folding for one or more molecules, as well as alignments.
    * Minimum free energy folding for one or more molecules, as well as alignments..
    * Centroid structure folding for one or more molecules.
    * 2DFold (MFE and partition function).
    * Maximum expected accuracy folding.
    * Generation of suboptimal structures and energies.
  * Constraints:
    * Hard constraints are fully supported.
    * Soft constraints are fully supported.
    * Structured ligand binding constraints are fully supported.
  * Model Details:
    * Updating of model details associated with a molecule.
    * Generating MFE and PF parameters from model details.
    * Macro for easily generating model details.
  * Parameters:
    * Updating of parameters associated with a molecule.
  * Probability Matrix:
    * Probability matrix exposed as `Probabilities = ref object`.
    * Extracting values from the probability matrix of
      partition function folding.
    * Generating a Density Plot of the base pairing probability
      in a terminal emulator.
  * Miscellaneous:
    * Generating reasonably random DNA/RNA sequences.
    * Evaluating energies of secondary structures.
    * Sampling secondary structures from ensembles computed with
      `pf` and `pf2D`.
    * Iterators for all types which can be iterated over.
    * Reading and writing parameter files.

## What do I need to use it?
You need either `RNA.so` or `libRNA.a` in your `PATH`. Both come with an installation of
ViennaRNA 2.x or later. Do not use earlier ones.

If you do not have `RNA.so` in your `PATH`, but __do__ have `libRNA.a`, you need to use
the compiler options `--dynlibOverride:RNA` and `--passL:"PATH-TO-libRNA.a -fopenmp"`, to
successfully statically link ViennaRNA.

## A short example
```nim
# We want to fold a sequence at multiple temperatures,
# and see how the base pairing probabilities change:
import nimna
import strutils

let rna = compound"GGGGGAGGAAACCTTCCCC"

for deltaT in 0..200:
  let T = 20.0 + deltaT.float / 10.0
  discard rna.update(settings(temperature = T)).pf
  if deltaT != 0:
    # This makes use of ANSI-escapes to move the cursor
    # up to the beginning of the plot, to write over it
    # again, so we can have a nice animation.
    echo "\e[$1A" % $(rna.length + 2)
  rna.densityPlot
```

## Short term plans
Exam season is over, so I can finally get back to this project. The
following steps I shall tackle over the next weeks
(in more or less chronological order):

- [ ] Make this a **nimble** package.
- [ ] Create bindings for the JS backend using the emscriptened version of
      ViennaRNA.
- [x] Implement utilities for NA sequence design based on user-defined fitness
      functions using an "artificial immune system" scheme.
- [ ] Achieve better test coverage.
