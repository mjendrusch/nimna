#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

const rnaLib = "RNA.so"

include base/data_structures
include base/model
include base/dp_matrices
include base/params
include base/constraints_hard
include base/constraints_soft
include base/constraints_ligand
include base/constraints_SHAPE
include base/read_epars
include base/unstructured_domains
include base/part_func
include base/part_func_co
include "base/2Dfold"
include "base/2Dpfold"
include base/mfe
include base/mea
include base/centroid
include base/duplex
include base/perturbation_fold
include base/equilibrium_probs
include base/boltzmann_sampling
include base/structure_utils
