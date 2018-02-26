# TODO

## Short term
* [x] dependency fetching and building *via* NimScript.
* [x] improve documentation.
* [ ] improve test coverage.
* [ ] add to Nimble package list.
* [ ] figure out a way to automatically check for the presence
  of dynamic / static libraries.
* [ ] do dependency fetching and building on nimble install.
* [ ] automatically build base from latest ViennaRNA using c2nim.

## Long term
* [ ] add JS backend support.
* [ ] add emscripten support and dependency building *via* NimScript.
* [ ] add the algorithm from https://doi.org/10.1093/bioinformatics/btx263 for
  nucleic acid design.

## Non-goals
* anything involving nucleic acids as genetic material.
* anything involving molecular dynamics. This has to happen in a
  separate package.
