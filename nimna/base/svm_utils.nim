#
# nimna - *NA folding for Nim
#
# (c) Copyright 2017 Michael Jendrusch. All rights reserved.
# This library is licensed under the MIT license.
# For more information see LICENSE.

when defined(withSVM):
  var
    avgModelString* {.importc: "avg_model_string", dynlib: rnaLib.}: cstring
    sdModelString* {.importc: "sd_model_string", dynlib: rnaLib.}: cstring

  proc getZ*(sequence: cstring; energy: cdouble): cfloat {.cdecl, importc: "get_z",
      dynlib: rnaLib.}
  proc avgRegression*(n: cint; a: cint; c: cint; g: cint; t: cint; avgModel: ptr SvmModel;
                     info: ptr cint): cdouble {.cdecl, importc: "avg_regression",
      dynlib: rnaLib.}
  proc sdRegression*(n: cint; a: cint; c: cint; g: cint; t: cint; sdModel: ptr SvmModel): cdouble {.
      cdecl, importc: "sd_regression", dynlib: rnaLib.}
  proc minimalSd*(n: cint; a: cint; c: cint; g: cint; t: cint): cdouble {.cdecl,
      importc: "minimal_sd", dynlib: rnaLib.}
  proc svmLoadModelString*(modelString: cstring): ptr SvmModel {.cdecl,
      importc: "svm_load_model_string", dynlib: rnaLib.}
  proc getSeqComposition*(s: ptr cshort; start: cuint; stop: cuint; length: cuint): ptr cint {.
      cdecl, importc: "get_seq_composition", dynlib: rnaLib.}
