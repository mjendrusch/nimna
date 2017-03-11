#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

template len*(al: Alignment): int =
  al.nSeqs

proc freeAlignment(al: Alignment) =
  # Have to use C's ``calloc`` and free, as it is used
  # by ViennaRNA, and I am not sure if it would be wise
  # to try using different allocators on one piece of memory.
  for idx in 0 ..< al.len:
    al.names[idx].free
    al.algn[idx].free
  al.names.free
  al.algn.free
  al.id.free
  al.structure.free

proc alignment*(path: string): Alignment =
  ## Reads a sequence alignment from a file. The following formats are
  ## supported:
  ##
  ## ClustalW, Stockholm 1.0, FASTA (Pearson), MAF
  new result, freeAlignment
  result.nSeqs = vrnaFileMsaRead(
    path.cstring,
    result.names.unsafeAddr,
    result.algn.unsafeAddr,
    result.id.unsafeAddr,
    result.structure.unsafeAddr,
    0
  ).int

proc alignment*(sequences, names: openarray[string]): Alignment =
  ## Creates an Alignment from a set of prealigned sequences and sequence names.
  new result, freeAlignment
  doAssert sequences.len == names.len,
    "Arrays or seqs of equal length need to be passed."
  result.nSeqs = sequences.len
  result.algn = cast[cstringArray](
    calloc((sequences.len + 1).cuint,  sizeof(cstring).cuint))
  result.names = cast[cstringArray](
    calloc((names.len + 1).cuint, sizeof(cstring).cuint))
  for idx in 0 ..< sequences.len:
    result.algn[idx] = cast[cstring](
      calloc((sequences[idx].len + 1).cuint, sizeof(char).cuint))
    result.names[idx] = cast[cstring](
      calloc((names[idx].len + 1).cuint, sizeof(char).cuint))
    result.algn[idx].copyMem(sequences[idx][0].unsafeAddr,
      (sequences[idx].len) * sizeof(char))
    result.names[idx].copyMem(names[idx][0].unsafeAddr,
      (names[idx].len) * sizeof(char))

proc sequence*(al: Alignment, idx: int): string =
  ## Returns the sequence at the idx'th position in an Alignment.
  doAssert idx < al.len,
    "The index of a sequence may not be greater or equal to the number of sequences present."
  doAssert idx >= 0,
    "The index of a sequence may not be less than zero."
  $al.algn[idx]

proc name*(al: Alignment, idx: int): string =
  ## Returns the name at the idx'th position in an Alignment.
  doAssert idx < al.len,
    "The index of a name may not be greater or equal to the number of names present."
  doAssert idx >= 0,
    "The index of a name may not be less than zero."
  $al.names[idx]

iterator sequences*(al: Alignment): string =
  ## Iterates over sequences in an Alignment.
  for idx in 0 ..< al.len:
    yield $al.algn[idx]

iterator names*(al: Alignment): string =
  ## Iterates over names in an Alignment.
  for idx in 0 ..< al.len:
    yield $al.names[idx]

iterator pairs*(al: Alignment): tuple[name, sequence: string] =
  ## Iterates over pairs of sequences and sequence names in an Alignment.
  for idx in 0 ..< al.len:
    yield ($al.names[idx], $al.algn[idx])
