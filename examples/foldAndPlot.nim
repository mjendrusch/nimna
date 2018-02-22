#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

import strutils
import nimna

## A small command line utility to fold a rna sequence and display its
## base pair probability matrix as a density plot in the terminal at
## different temperatures, for different values of

when isMainModule:
  import commandeer

  proc main =
    commandline:
      argument sequence, string
      option T, float, "temperature", "T", 37.0
      option gamma, float, "gamma", "g", 1.0
      option movie, bool, "movie", "m"
      option grayScale, bool, "grayscale", "G"
      exitoption "help", "h",
                 "Usage: foldAndPlot <string>"
      errormsg "Usage: foldAndPlot <string>"

    template `%`(str: string; a: tuple): string =
      var intermediate: seq[string] = @[]
      for _, val in a.fieldPairs:
        intermediate.add($val)
      str % intermediate

    var
      comp = compound(sequence)
      scale = if grayScale:
          csGrayScale
        else:
          csBlueRed
    comp.update settings(temperature = T)

    if '&' in sequence:
      echo "Folding dimer at $1°C --------------------------------------------------" % $T
      echo "Energies: $1 \n Structure: $2                                           " % comp.pfDimer
      echo "Energy: $1 \n Structure: $2                                             " % comp.mfeDimer
      echo "Probability density plot at gamma = $1                                  " % $gamma
      comp.densityPlot gamma, scale
    else:
      if movie:
        for i in -100..100:
          if i != -100:
            echo "\e[$1A" % $(comp.length + 9)
          comp.update settings(temperature = T + i.float / 10)
          echo "Folding at $1°C --------------------------------------------------------" % $(T + i.float / 10.0)
          echo "Ensemble Energy: $1\nEnsemble Structure: $2                             " % comp.pf
          echo "MFE: $1\nMFE Structure: $2                                              " % comp.mfe
          echo "Sequence:      $1                                                       " % sequence
          echo "Probability density plot at gamma = $1                                  " % $(gamma)
          comp.densityPlot gamma, scale
      else:
        comp.update settings(temperature = T)
        echo "Folding at $1°C --------------------------------------------------------" % $T
        echo "Ensemble Energy: $1\nEnsemble Structure: $2                             " % comp.pf
        echo "MFE: $1\nMFE Structure: $2                                              " % comp.mfe
        echo "Sequence:      $1                                                       " % sequence
        echo "Probability density plot at gamma = $1                                  " % $(gamma)
        comp.densityPlot gamma, scale
    echo "---------------------------------------------------------- done."

  main()
