mode = ScriptMode.Verbose

packageName    = "nimna"
version        = "0.1.0"
author         = "Michael Jendrusch"
description    = "Nucleic acid folding in Nim"
license        = "MIT"
skipDirs       = @["tests", "examples", "experimental"]
skipFiles      = @["nimna.html", "api.html"]

requires "nim >= 0.17.3"

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

when defined(windows):
  task deps, "build dependencies":
    exec "powershell.exe \"iwr -outf viennaInstaller.exe https://www.tbi.univie.ac.at/RNA/download/win/windows/Install-ViennaRNA-2.4.3_64bit.exe\""
    exec "viennaInstaller.exe"
else:
  task deps, "build dependencies":
    exec "mkdir deps"
    exec "wget -O ./deps/vrna.tar.gz https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.3.tar.gz"
    exec "cd ./deps && tar -xzf vrna.tar.gz"
    exec "cd ./deps/ViennaRNA-2.4.3 && ./configure && make"
  task jsDeps, "build dependencies for the JS backend":
    discard


task test, "run nimna tests":
  testConfig()
  setCommand "c", "tests/tall.nim"

task examples, "build nimna example applications":
  exampleConfig()
  setCommand "c", "examples/foldAndPlot.nim"
  setCommand "c", "examples/randomSearch.nim"
