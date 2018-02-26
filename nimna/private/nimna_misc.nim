#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

## .. include:: ../../docs/misc.txt

import strutils, math, random
import RNA
import nimna_types, nimna_cutils, nimna_compound, nimna_probabilities,
       nimna_fold

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

proc densityPlot*(c: Compound, gamma: float,
                  scheme: ColorScheme = csGrayScale) =
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
proc readPars*(path: string) {. inline .} =
  ## Reads an folding parameter file located at ``path``.
  readParameterFile(path.cstring)
proc writePars*(path: string) {. inline .} =
  ## Writes the current paramsters to a file at ``path``.
  writeParameterFile(path.cstring)

# Utilities for DNA/RNA processing

proc complement*(a: char): char {. inline .} =
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
  ## Returns a random DNA of a given ``length``.
  result = newStringOfCap(length)
  for i in 0 ..< length:
    result.add ['G', 'A', 'T', 'C'].rand

proc randomDNAofStructure*(structure: string): string =
  ## Returns a random DNA with a certain projected
  ## secondary ``structure``.
  result = newString(structure.len)
  var
    open = newSeqOfCap[int](int(structure.len div 2 + 1))
    close = newSeqOfCap[int](int(structure.len div 2 + 1))
  for idx in 0 ..< structure.len:
    case structure[idx]
    of '(':
      open.add(idx)
    of ')':
      close.insert(idx, 0)
    else:
      result[idx] = ['G', 'A', 'T', 'C'].rand
  for idx in 0 ..< open.len:
    result[open[idx]] = ['G', 'A', 'T', 'C'].rand
    result[close[idx]] = result[open[idx]].complement
