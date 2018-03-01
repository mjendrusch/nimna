# nimna
**nim** **n**ucleic **a**cid folding.

## What is nimna?

**nimna** is a set of bindings to [ViennaRNA](https://www.tbi.univie.ac.at/RNA/), a library for RNA and DNA folding  applications. It consists of a very thin `c2nim` wrapper `RNA.nim`, as well as a high level interface `nimna.nim`, which wraps the many pointers used in the ViennaRNA into garbage collected `ref objects` to make the library easier to use. Furthermore, it provides nucleic acid design functionality in the form of an 'artificial immune-system' algorithm in `design.nim`.

## Installation

Installation of `nimna` and its dependencies is automatically handled using `nimble install`. This tries to autodetect, whether a suitable dynamic library version of `libRNA` exists on your computer. If that is not the case, it pulls all files necessary for installation from the web and installs them. In case of Windows, the ViennaRNA installer is started and you may need to complete the
some installation steps manually, while for \*nix ViennaRNA is built from source. As such, it suffices for most use-cases to just perform:

```
$ nimble install nimna
```

or

```
$ nimble install <this repository's url>
```

As nimble currently does not allow `uninstall` hooks, `nimna` provides a command to clean up dependencies, should you want to uninstall `nimna`:

```
$ nimnacleanup
```

This removes the dependency folder in the `nimna` package. If this is not done, nimble cannot fully remove `nimna's` package directory, leaving the deps folder to lie around.

## What can I do with it?
`nimna` currently provides the functionality implemented in ViennaRNA, as well as some extra bits. As `nimna`'s current status is a *work-in-progress*, the set of available functionality will be steadily growing. You can find more documentation, as well as short examples for every submodule [here](https://mjendrusch.github.io/projects/nimna/nimna)

Here's an incomplete list of what can be done with `nimna`:

### Partition function (pf) and minimum free energy (mfe) folding
Folding for single molecules:
```nim
let
  sequence = compound"CCCCCAAAGGGGG"
  mfeResult = sequence.mfe
  pfResult = sequence.pf
echo mfeResult.struc # prints (((((...)))))
echo mfeResult.E     # prints the free energy
                     # of folding in kcal/mol
echo pfResult.struc  # prints (((((...)))))
echo pfResult.E      # prints the ensemble free
                     # energy of folding in kcal/mol
```
Folding for dimers and alignments works analogously after creation of suitable `Compound` objects.

### Free energy evaluation of structures
When no full folding prediction is required, `nimna` allows for the computation of free energies of given secondary structures for a `Compound`:

```nim
echo sequence.eval("(((((...)))))") # Prints the free
                                    # energy of folding
                                    # for the given
                                    # structure.
echo sequence.evalRemove(
  "(((((...)))))", 0, 12) # Prints the free energy of
                          # removing the base pair of
                          # the first and last
                          # nucleotides
echo sequence.evalAdd(
  ".((((...)))).", 0, 12) # Prints the free energy of
                          # adding a base pair between
                          # the first and last
                          # nucleotides
```

### Access to base pairing probabilities

When using partition function folding (`pf`), base pairing probabilities are set in the `Compound` object, an immutable view of which can be created later:

```nim
let probs = sequence.probabilities
echo probs[i, j] # prints the probability of bases
                 # i and j in `sequence` forming
                 # a base pair.
echo sequence.prob(i, j) # prints the same as above.
```

A `Probabilities` object created from a `Compound` may be iterated over using a set of iterators provided in `nimna`:

```nim
for elem in probs.items:
  echo elem # prints each and every
            # entry in the probability matrix.

for pos, prob in probs.pairs:
  echo pos.i, " : ", pos.j, " : ", prob
  # prints the base positions together
  # with the associated probabilities.

for i, j, prob in probs.triples:
  echo i, " : ", j, " : ", prob
  # prints the same as above.

for pos in probs.positions:
  for elem in pos:
    echo elem # for every base in the Compound
              # prints the base pairing probability
              # of that base with all other bases.
```

### Fine tuning of folding parameters

Although standard folding parameters are often deemed sufficient for many use cases, tuning of parameters may be required for more specialized analyses. To that end `nimna` provides the means to adjust the folding parameters at will:

```nim
# Use the `settings` macro to create a new
# set of folding parameters:
let
  settings = settings(
    temperature = 25.0, # Set the folding
                        # temperature to 25°C
    noGU = 1            # Disallow G--U base pairs
  )
  # Parameters for mfe folding
  mfeParams = settings.toParams
  # Parameters for pf folding
  pfParams = settings.toScaledParams

# Now, update the compound with those parameters:
sequence.update(mfeParams) # Update parameters
                           # for mfe folding only.
sequence.update(pfParams)  # Update parameters
                           # for pf folding only.
sequence.update(settings)  # Update all parameters.
```

### Application of soft and hard constraints to compounds
For certain applications, for example for working with aptamers protein binding domains, Ag-nanocluster forming sequences and other sequences with strong outside (i.e. non DNA/RNA) influences on folding, it is necessary to inform the folding algorithm about the presence of those structures. This is done using (hard or soft) constraints encoding the outside influence, its free energy of
interaction and the resulting secondary structure resulting upon interaction. To that end, `nimna` provides access to the full spectrum of constraints implemented in ViennaRNA.

Hard constraints __force__ the nucleic acid to fold in certain ways, regardless of other, perhaps more favourable interactions involved. They are set using `forceX`, where `X` is one of `paired, unpaired`:

```nim
# Given a compound `sequence`, constrain its
# i'th and j'th base to pair:
sequence.forcePaired(i, j)
# constrain its k'th base to stay unpaired:
sequence.forceUnpaired(k)
# constrain it according to a dot-bracket string:
sequence.constrain("x((((xxx))))x") # 'x' means:
                                    # must not pair
# lift all constraints
sequence.liftConstraints
```

Soft constraints register base pairs or motifs with a certain __preferred__ free energy of interaction, which are then incorporated into folding prediction. This allows for correct folding, when lower energy interactions outside the constraints are available. They are set using `preferX`, where `X` is one of `paired, unpaired`:

```nim
# Given a compound `sequence`, add a beneficial
# free energy contribution of -10.0 kcal/mol to
# the base pairing of its i'th and j'th base:
sequence.preferPaired(i, j, -10.0)
# Do the same for its k'th base to stay unpaired:
sequence.preferUnpaired(k, -10.0)
# Do the same for a motif `CCAA` in `sequence`
sequence.preferMotif("CCAA", -10)
# Lift all preferences
sequence.liftPreferences
```

### Nucleic acid design
`nimna` provides an 'artificial immune system'-based nucleic acid design algorithm for automatic design of nucleic acids according to a user-specified fitness function:

```nim
# Define a fitness function:
proc fitness(c: Compound): float =
  c.eval("(((((((...))))..)))")

# create a new `DesignEngine`:
let design = newEngine(20, fitness)
# constrain the sequence space to be searched:
design.pattern = "NNNNNNNATGCNNNYHGNN"
# specify a structure for structure-consistent mutation.
# this ensures, that the three base pairs around the
# three-nucleotide-loop are mutated together, such that
# they form Watson-Crick base pairs:
design.structure = "....(((...)))......"
# set the folding parameters:
design.settings = settings(temperature = 25.0)
# set the mutation probability:
design.mutationProbability = 0.6
# run the algorithm for 100 steps:
design.step(100)
# print the best sequence according to
# the fitness function:
echo design.best.sequence
```

### A more complete list of available functionality

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
* Nucleic acid design:
  * Generating nucleic acid sequences corresponding to local minima in
    user-defined fitness functions.
* Miscellaneous:
  * Generating reasonably random DNA/RNA sequences.
  * Evaluating energies of secondary structures.
  * Sampling secondary structures from ensembles computed with
    `pf` and `pf2D`.
  * Iterators for all types which can be iterated over.
  * Reading and writing parameter files.

## A short example:

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

## iGEM disclaimer

`nimna` is not a project of a Heidelberg iGEM team, future or past. Certainly, it was inspired by the work of the [Heidelberg iGEM team 2015](http://2015.igem.org/Team:Heidelberg) but it is its own project, which I work on, on my own time and which **will be maintained and supported**, in contrast to some iGEM code out there.
