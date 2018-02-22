#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

when defined(windows):
  const rnaLib = "libRNA.dll"
elif defined(darwin):
  const rnaLib = "libRNA.dylib"
else:
  const rnaLib = "libRNA.so"

{. push warning[SmallLshouldNotBeUsed]: off .}

include ../base/data_structures
include "../base/2Dfold"
include "../base/2Dpfold"
include ../base/ali_plex
include ../base/aln_util
include ../base/alphabet
include ../base/boltzmann_sampling
include ../base/centroid
include ../base/cofold
include ../base/constraints_hard
include ../base/constraints_ligand
include ../base/constraints_SHAPE
include ../base/constraints_soft
include ../base/convert_epars
include ../base/dist_vars
include ../base/dp_matrices
include ../base/duplex
include ../base/energy_par
include ../base/equilibrium_probs
include ../base/eval
include ../base/exterior_loops
include ../base/file_formats
include ../base/file_formats_msa
include ../base/file_utils
include ../base/findpath
include ../base/fold
include ../base/gquad
include ../base/hairpin_loops
include ../base/interior_loops
include ../base/inverse
include ../base/Lfold
include ../base/LPfold
include ../base/mea
include ../base/mfe
include ../base/model
include ../base/move_set
include ../base/multibranch_loops
include ../base/naview
include ../base/params
include ../base/part_func
include ../base/part_func_co
include ../base/part_func_up
include ../base/perturbation_fold
include ../base/PKplex
include ../base/plex
include ../base/plot_aln
include ../base/plot_layouts
include ../base/plot_structure
include ../base/ProfileAln
include ../base/profiledist
include ../base/PS_dot
include ../base/read_epars
include ../base/ribo
include ../base/RNAstruct
include ../base/snofold
include ../base/snoop
include ../base/string_utils
include ../base/stringdist
include ../base/structure_utils
include ../base/structured_domains
include ../base/subopt
include ../base/svm_utils
include ../base/units
include ../base/unstructured_domains
include ../base/utils

{.pop.}
