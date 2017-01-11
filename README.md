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
growing.

Currently, the following things are available with the high level interface:

  * Folding:
    * Partition function folding for one or more molecules.
    * Minimum free energy folding for one or more molecules.
  * Constraints:
    * Hard constraints are fully supported.
  * Model Details:
    * Updating of model details associated with a molecule.
    * Generating MFE and PF parameters from model details.
    * Macro for easily generating model details.
  * Parameters:
    * Updating of parameters associated with a molecule.
  * Probability Matrix:
    * Extracting values from the probability matrix of
      partition function folding.
    * Generating a Density Plot of the base pairing probability
      in a terminal emulator.
  * Miscellaneous:
    * Generating reasonably random DNA/RNA sequences.
    
## What do I need to use it?
You need either `RNA.so` or `libRNA.a` in your `PATH`. Both come with an installation of
ViennaRNA 2.x or later. Do not use earlier ones.

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
You can expect this to happen over the next few days or weeks, at most
(in chronological order):

- [ ] Wrap the remaining ViennaRNA headers.
- [ ] Create a high level wrapper for *parameter file IO*.
- [ ] Create a high level wrapper for all remaining flavours
  of constraints.
- [ ] Create a high level wrapper for centroid structure prediction.
- [ ] Create a high level wrapper for MEA structure prediction.
- [ ] Create a high level wrapper for comparative structure prediction.
- [ ] Create a high level wrapper for 2Dfold.
- [ ] Create a high level wrapper for duplex fold.
- [ ] Create a high level wrapper for subopt.
- [ ] Create a high level wrapper for local fold.
- [ ] Create a high level wrapper for structure evaluation.
- [ ] Make this a **nimble** package.
