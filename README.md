# PardisoMKL

This package provides Julia bindings to the low level routines provided by the [Intel (R) MKL Pardiso direct sparse solver interface](https://software.intel.com/en-us/mkl-developer-reference-fortran-intel-mkl-pardiso-parallel-direct-sparse-solver-interface). This package can only be used if a licended instalation of the Intel (R) MKL Pardiso is available in the system.  This package is available free of charge and in no way replaces or alters any functionality of the linked libraries.

## Why?

The goal of this package is to provide very thin wrappers to the low level Pardiso FORTRAN routines. The signatures of the Julia wrappers use only built-in types and are almost one-to-one to the signatures of the wrapped FORTRAN subroutines. This allows advanced users to have fine control over the Pardiso solver. If you are looking for a more user-friendly way to interface with Pardiso, then use the [Pardiso.jl](https://github.com/JuliaSparse/Pardiso.jl) package.

## Installation

* Set the `MKLROOT` environment variable. See the [MKL getting started manual](https://software.intel.com/en-us/articles/intel-mkl-103-getting-started) for a thorough guide how to set this variable correctly, typically done by executing something like `source /opt/intel/bin/compilervars.sh intel64`.
* Make sure that `gcc` is installed and that can be found via the `$PATH` environment variable.
* Install `PardisoMKL` as any other Julia package.

## API

The functions exported by `PardisoMKL` have the names of the underlying FORTRAN routines appended with an explamation sign (!) to denote that they modify some of the arguments. The julia wrappers return an integer error code if the underlying FORTRAN subrotuine accept an integer error code in the last argument.

```julia
pardisoinit!(pt::Vector{Int},mtype::Integer,iparm::Vector{Int32})
```
```julia
pardiso!( pt::Vector{Int}, maxfct::Integer, mnum::Integer, mtype::Integer,
  phase::Integer, n::Integer, a::Vector{T}, ia::Vector{Int32},
  ja::Vector{Int32}, perm::Vector{Int32}, nrhs::Integer, iparm::Vector{Int32},
  msglvl::Integer, b::Vector{T}, x::Vector{T})::Int where T
```
  
```julia
pardiso_64!(pt::Vector{Int}, maxfct::Integer, mnum::Integer, mtype::Integer,
  phase::Integer, n::Integer, a::Vector{T}, ia::Vector{Int64},
  ja::Vector{Int64}, perm::Vector{Int64}, nrhs::Integer, iparm::Vector{Int64},
  msglvl::Integer, b::Vector{T}, x::Vector{T})::Int where T
```

See the [Intel (R) MKL Pardiso manual](https://software.intel.com/en-us/mkl-developer-reference-fortran-intel-mkl-pardiso-parallel-direct-sparse-solver-interface) for the particular meaning of each argument.

