mode = ScriptMode.Verbose

packageName    = "nimna"
version        = "0.1.0"
author         = "Michael Jendrusch"
description    = "Nucleic acid folding in Nim"
license        = "MIT"
skipDirs       = @["tests", "examples", "experimental"]
skipFiles      = @["nimna.html", "api.html"]

requires "nim >= 0.17.3"

proc testConfig() =
  --linedir: on
  --stacktrace: on
  --linetrace: on
  --debuginfo
  --path: "."
  --passL: "-lstdc++"
  --run

proc exampleConfig() =
  --define: release
  --path: "."

when defined(windows):
  task deps, "build dependencies":
    exec "powershell.exe \"iwr -outf viennaInstaller.exe https://www.tbi.univie.ac.at/RNA/download/win/windows/Install-ViennaRNA-2.4.3_64bit.exe\""
    exec "viennaInstaller.exe"
else:
  task deps, "build dependencies":
    exec "mkdir -p deps/lib"
    exec "wget -O ./deps/vrna.tar.gz https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.3.tar.gz"
    exec "cd ./deps && tar -xzf vrna.tar.gz"
    ## Disable link-time optimization, linking takes ages otherwise.
    ## Disable C11 features.
    exec "cd ./deps/ViennaRNA-2.4.3 && ./configure --prefix=$(readlink -f \"../\") --disable-c11 --disable-lto && make && make install"
  task jsDeps, "build dependencies for the JS backend":
    discard

after install:
  ## Currently untested.
  ## Clean the install dir, should it still contain dependencies
  ## from a previous install.
  exec "cd $(nimble path nimna) && rm -rf deps"
  exec "cd $(nimble path nimna) && mkdir -p deps/lib"
  exec "cd $(nimble path nimna) && wget -O ./deps/vrna.tar.gz https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.3.tar.gz"
  exec "cd $(nimble path nimna) && cd ./deps && tar -xzf vrna.tar.gz"
  ## Disable link-time optimization, linking takes ages otherwise.
  ## Disable C11 features.
  exec "cd $(nimble path nimna) && cd ./deps/ViennaRNA-2.4.3 && ./configure --prefix=$(readlink -f \"../\") --disable-c11 --disable-lto && make && make install"
  exec "echo \"\" >> ~/.bashrc"
  exec "echo \"# nimna dependencies:\" >> ~/.bashrc"
  exec "echo \"export LIBRARY_PATH=$LIBRARY_PATH:$(nimble path nimna)/deps/lib/\" >> ~/.bashrc"
  exec "echo \"export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(nimble path nimna)/deps/lib/\" >> ~/.bashrc"
  exec "echo \"alias nimnacleanup=\\\"cd $(nimble path nimna) && rm -rf deps && cd -\\\"\" >> ~/.bashrc

after deps:
  when defined(windows):
    discard
  else:
    exec "echo \"\" >> ~/.bashrc"
    exec "echo \"# nimna dependencies:\" >> ~/.bashrc"
    exec "echo \"export LIBRARY_PATH=$LIBRARY_PATH:$(nimble path nimna)/deps/lib/\" >> ~/.bashrc"
    exec "echo \"export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(nimble path nimna)/deps/lib/\" >> ~/.bashrc"
    exec "echo \"alias nimnacleanup=\\\"cd $(nimble path nimna) && rm -rf deps && cd -\\\"\" >> ~/.bashrc"

task docs, "build nimna docs":
  exec "mkdir -p htmldocs"
  exec "mkdir -p htmldocs/nimna"
  exec "mkdir -p htmldocs/nimna/private"
  exec "mkdir -p htmldocs/nimna/base"
  exec "cd nimna && nim doc2 design.nim"
  --project
  --path:"."
  setCommand "doc2", "nimna.nim"
after docs:
  exec "mv nimna/design.html htmldocs/nimna/design.html"

task test, "run nimna tests":
  testConfig()
  setCommand "c", "tests/tall.nim"

task examples, "build nimna example applications":
  exampleConfig()
  setCommand "c", "examples/foldAndPlot.nim"
  setCommand "c", "examples/randomSearch.nim"
