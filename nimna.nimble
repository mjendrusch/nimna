mode = ScriptMode.Verbose

packageName    = "nimna"
version        = "0.1.0"
author         = "Michael Jendrusch"
description    = "Nucleic acid folding in Nim"
license        = "MIT"
skipDirs       = @["tests", "examples", "experimental"]
skipFiles      = @["nimna.html", "api.html"]

requires "nim >= 0.13.1"

--forceBuild

proc testConfig() =
  --define:release
  --hints: off
  --linedir: on
  --stacktrace: on
  --linetrace: on
  --debuginfo
  --path: "."
  --dynlibOverride: RNA
  --passL: "-lRNA -fopenmp -fno-lto"
  --run

proc exampleConfig() =
  --define: release
  --path: "."
  --dynlibOverride: RNA
  --passL: "-lRNA -fopenmp -fno-lto"

task test, "run nimna tests":
  testConfig()
  setCommand "c", "tests/tall.nim"

task examples, "build nimna example applications":
  exampleConfig()
  setCommand "c", "examples/foldAndPlot.nim"
  setCommand "c", "examples/randomSearch.nim"
