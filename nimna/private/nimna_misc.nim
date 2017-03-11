#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

# Structure sampling from an ensemble

proc sample*(c: Compound): string =
  ## Samples a secondary structure from an ensemble according to its probability.
  withRef c:
    let structure = vrnaPBacktrack(c.vfc)
    result = $structure
  dealloc structure

proc sample2D*(c: Compound2D; distance1, distance2: int): string =
  ## Samples a secondary structure at a position in secondary structure
  ## space with distance1 from one reference structure and distance2 from
  ## the other.
  withRef c:
    let structure = vrnaPBacktrackTwoD(c.vfc, distance1.cint, distance2.cint)
    result = $structure
  dealloc structure

# Utilities for plotting:

proc colorize(s: string, color: uint8): string =
  "\e[48;5;$2m$1\e[m".format(s, color)

type ColorScheme* = enum
  csGrayScale, csBlueRed

proc toGrayscale(f: float, gamma: float): string =
  var num = uint8(pow(f, gamma) * 25) + 232
  if num < 232: num = 255
  result = colorize("  ", num)

proc toBlueRed(f: float, gamma: float): string =
  var num = int(pow(f, gamma) * 12)
  if num < 6:
    num += 16
  else:
    num = 201 - num + 6
  result = colorize("  ", num.uint8)

proc densityPlot*(c: Compound, gamma: float, scheme: ColorScheme = csGrayScale) =
  ## Create a colored density plot of the base pairing probabilities in the
  ## Compound, in a terminal emulator compatible with ANSI-escapes.
  let toColorScheme = case scheme:
    of csGrayScale:
      toGrayscale
    of csBlueRed:
      toBlueRed
  echo "  ", ($c.sequence).join" "
  for i in 0 ..< c.length.int:
    var seqI = " "
    for j in 0 ..< c.length.int:
      if i == j:
        seqI.add(colorize("  ", 255))
      else:
        seqI.add(toColorScheme(c.prob(i, j), gamma))
    echo c.sequence[i], seqI

# Read and write energy parameter files:
proc readPars*(path: string) =
  readParameterFile(path.cstring)
proc writePars*(path: string) =
  writeParameterFile(path.cstring)

# Utilities for DNA/RNA processing

proc complement*(a: char): char =
  ## Returns the complement of a DNA base.
  case a
  of 'a', 'A':
    result = 'T'
  of 'b', 'B':
    result = 'V'
  of 't', 'T', 'u', 'U':
    result = 'A'
  of 'v', 'V':
    result = 'B'
  of 'c', 'C':
    result = 'G'
  of 'd', 'D':
    result = 'H'
  of 'g', 'G':
    result = 'C'
  of 'h', 'H':
    result = 'D'
  of 'r', 'R':
    result = 'Y'
  of 'y', 'Y':
    result = 'R'
  of 'w', 'W', 's', 'S':
    result = a
  else:
    result = 'N'

proc randomDNA*(length: int): string =
  ## Returns a random DNA of a given length.
  result = newStringOfCap(length)
  for i in 0 ..< length:
    result.add random(['G', 'A', 'T', 'C'])

proc randomDNAofStructure*(struc: string): string =
  ## Returns a random DNA with a certain projected secondary structure.
  result = newString(struc.len)
  var
    open = newSeqOfCap[int](int(struc.len / 2 + 1))
    close = newSeqOfCap[int](int(struc.len / 2 + 1))
  for idx in 0 ..< struc.len:
    case struc[idx]
    of '(':
      open.add(idx)
    of ')':
      close.insert(idx, 0)
    else:
      result[idx] = ['G', 'A', 'T', 'C'].random
  for idx in 0 ..< open.len:
    result[open[idx]] = ['G', 'A', 'T', 'C'].random
    result[close[idx]] = result[open[idx]].complement
