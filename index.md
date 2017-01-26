## What is nimna?

**nimna** is a set of bindings to ViennaRNA, a library for RNA and DNA folding applications.
It consists of a very thin wrapper `RNA.nim`, as well as a high level interface `nimna.nim`,
which wraps the many pointers used in the ViennaRNA into garbage collected `ref objects` to
make the library easier to use.

## What can I do with it?

Currently, **nimna** is very experimental and a *work in progress*. Thus, the currently
available functionality in the high level interface is quite limited, but will be steadily
growing. You can find documentation [here](https://mjendrusch.github.io/nimna/api.html).

Currently, the following things are available with the high level interface:

  * Folding:
    * Partition function folding for one or more molecules, as well as alignments.
    * Minimum free energy folding for one or more molecules, as well as alignments.
    * Minimum free energy folding with a sliding window.
    * Centroid structure folding for one or more molecules.
    * 2DFold (MFE and partition function).
    * Maximum expected accuracy folding.
    * Generation of suboptimal structures and energies.
  * Constraints:
    * Hard constraints are fully supported.
    * Soft constraints are fully supported.
    * Structured and unstructured ligand binding constraints are fully supported.
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

## A Demo of upcoming JavaScript support:
Have a look at a simple RNA folding demo [here](https://mjendrusch.github.io/nimna/demo.html).
JavaScript support based on emscripten for the whole library will be ready soon.

This is the nim code used to generate the demo. It uses `D3.js` to plot the
predicted RNA/DNA secondary structures. The fully functional `D3.js` wrapper
used here is a work in progress, and will be available soon.

```nim
import d3select
import future, strutils

type
  RootPtr = distinct cint
  Sptr = distinct cint
  Cptr = distinct cint
  Fptr = distinct cint

# Wrap some emscriptened procedures.
proc internalFold(sq: Cptr, struc: Cptr): cfloat {. importc: "_vrna_fold" .}
proc simpleCoords(pairs: Sptr, x, y: Fptr): cint {. importc: "_simple_xy_coordinates" .}
proc pairTable(struc: Cptr): Sptr {. importc: "_vrna_ptable" .}

# Wrap some emscripten functionality
proc emMalloc(size: int): RootPtr {. importc: "Module._malloc" .}
proc emFree(p: RootPtr) {. importc: "Module._free" .}
proc stringToUtf8(s: cstring, p: Cptr, len: int) {. importc: "Module.stringToUTF8" .}
proc utf8ToString(p: Cptr): cstring {. importc: "Module.UTF8ToString" .}
proc getValue(f: FPtr): cfloat {. importcpp: "Module.getValue(#, 'float')" .}

# Decode a pair of emscripten float pointers to a seq of tuples.
proc decodeCoords(xPtr, yPtr: FPtr, len: int): seq[tuple[x, y: float]] =
  result = newSeq[tuple[x, y: float]](len)
  for idx in 0 ..< len:
    result[idx] = (
      x: getValue((xPtr.cint + sizeOf(cfloat) * idx).FPtr).float,
      y: getValue((yPtr.cint + sizeOf(cfloat) * idx).FPtr).float
    )

# Wrap all of that into a nice high level interface.
proc fold*(sq: cstring): tuple[E: float, struc: cstring, coords: seq[tuple[x, y: float]]] =
  let
    length = sq.len
    sqPtr = emMalloc((length + 1) * sizeOf(char)).CPtr
    strucPtr = emMalloc((length + 1) * sizeOf(char)).CPtr
    xPtr = emMalloc((length) * sizeOf(float)).FPtr
    yPtr = emMalloc((length) * sizeOf(float)).FPtr
  defer:
    emFree sqPtr.RootPtr
    emFree strucPtr.RootPtr
    emFree xPtr.RootPtr
    emFree yPtr.RootPtr
  sq.stringToUtf8(sqPtr, length + 1)
  let
    energy = internalFold(sqPtr, strucPtr)
    pTable = strucPtr.pairTable
  let test = simpleCoords(pTable, xPtr, yPtr)
  defer: emFree pTable.RootPtr
  result.E = energy
  result.struc = strucPtr.utf8ToString
  result.coords = decodeCoords(xPtr, yPtr, length)

# Use wrapped D3.js functionality to plot the predicted secondary structures.
proc main =
  let
    textbox = select("#sequence")
    svg = select("div#foldDemo").append("svg")
      .attr("width", 10)
      .attr("height", 10)

  proc doTheMagic =
    ## Compute the folding of a sequence
    let sq = $property[cstring](textbox, "value")
    if sq.len == 0:
      return
    var
      res = fold(sq)
      maxX = 0.0
      minX = 1e6
      maxY = 0.0
      minY = 1e6
      newCoords = newSeq[tuple[x, y: float]](sq.len)
    # Adjust svg to fit the secondary structure.
    for elem in res.coords:
      if elem.x > maxX:
        maxX = elem.x
      if elem.x < minX:
        minX = elem.x
      if elem.y > maxY:
        maxY = elem.y
      if elem.y < minY:
        minY = elem.y
    for idx, elem in res.coords.pairs:
      newCoords[idx].x = elem.x - minX
      newCoords[idx].y = elem.y - minY
    svg.attr("width", maxX - minX + 40).attr("height", maxY - minY + 40)

    proc colorize(d: tuple[x, y: float], i: int): cstring =
      ## Closure to assign a color to each nucleotide
      case sq[i]:
        of 'g', 'G':
          "#CF2E00"
        of 'a', 'A':
          "#016481"
        of 't', 'T':
          "#009244"
        of 'u', 'U':
          "#004E24"
        of 'c', 'C':
          "#CF6800"
        else:
          "#606060"

    proc makeNTide[T: tuple[x, y: float]](s: Selection[T], size: int, color: proc(d: T, i: int): cstring) =
      ## Set all attributes for a nucleotide
      s.attr("cx", (d: tuple[x, y: float]) -> cstring => $(d.x + 30))
        .attr("cy", (d: tuple[x, y: float]) -> cstring => $(d.y + 30))
        .attr("r", size)
        .attr("stroke-width", "3px".cstring).attr("stroke", "black".cstring)
        .style("fill", color)

    # Do the usual D3.js procedure of adjusting given elements to fit new data,
    # adding additional elements, if there is more data than elements currently
    # available, or delete elements with no corresponding data.
    svg.selectAll("circle").data(newCoords).makeNTide(7, colorize)
    svg.selectAll("circle").data(newCoords)
      .enter.append("circle").makeNtide(7, colorize)
    svg.selectAll("circle").data(newCoords).exit.remove

  # Set the change handler for the sequence input element to predict and plot
  # the secondary structure.
  textbox.on("change", doTheMagic)
  doTheMagic()

main()
```

## Short term plans
You can expect this to happen over the next few days or weeks, at most
(in more or less chronological order):

- [x] Wrap the remaining ViennaRNA headers.
- [x] Create a high level wrapper for *parameter file IO*.
- [x] Create a high level wrapper for all remaining flavours
  of constraints.
- [x] Create a high level wrapper for centroid structure prediction.
- [x] Create a high level wrapper for MEA structure prediction.
- [x] Create a high level wrapper for comparative structure prediction.
- [x] Create a high level wrapper for 2Dfold.
- [x] ~~Create a high level wrapper for duplex fold.~~
      This functionality is given by using a dimer Compound,
      as already available.
- [x] Create a high level wrapper for subopt.
- [x] Create a high level wrapper for local fold.
- [x] Create a high level wrapper for structure evaluation.
- [ ] Make this a **nimble** package.
