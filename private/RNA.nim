#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const rnaLib = "RNA.so"

include data_structures
include model
include dp_matrices
include params
include constraints_hard
include constraints_soft
include constraints_ligand
include constraints_SHAPE
include read_epars
include unstructured_domains
include part_func
include part_func_co
include "2Dfold"
include "2Dpfold"
include mfe
include centroid
include duplex
include perturbation_fold
include equilibrium_probs
include boltzmann_sampling
