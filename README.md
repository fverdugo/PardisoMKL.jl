# PardisoMKL

This package provides Julia bindings to the low level routines provided by the [Intel (R) MKL Pardiso direct sparse solver interface](https://software.intel.com/en-us/mkl-developer-reference-fortran-intel-mkl-pardiso-parallel-direct-sparse-solver-interface). This package can only be used if a licended instalation of the Intel (R) MKL Pardiso is available in the system.  This package is available free of charge and in no way replaces or alters any functionality of the linked libraries.

## Why?

The goal of this package is to provide very thin wrappers to the low level Pardiso FORTRAN routines. The signatures of the Julia wrappers use only built-in types and are almost one-to-one to the signatures of the wrapped FORTRAN subroutines. This allows advanced users to have fine control over the Pardiso solver. If you are looking for a more user-friendly way to interface with Pardiso, then use the [Pardiso.jl](https://github.com/JuliaSparse/Pardiso.jl) package.

## Installation

* Set the `MKLROOT` environment variable. See the [MKL getting started manual](https://software.intel.com/en-us/articles/intel-mkl-103-getting-started) for a thorough guide how to set this variable correctly, typically done by executing something like `source /opt/intel/bin/compilervars.sh intel64`.
* Make sure that `gcc` is installed and that can be found via the `$PATH` environment variable.
* Install `PardisoMKL` as any other Julia package.

## API

The most of the functions exported by `PardisoMKL` have the names of the underlying FORTRAN routines appended with an explamation sign (!) to denote that they modify some of the arguments. The julia wrappers return an integer error code if the underlying FORTRAN subrotuine accept an integer error code in the last argument. See the [Intel (R) MKL Pardiso manual](https://software.intel.com/en-us/mkl-developer-reference-fortran-intel-mkl-pardiso-parallel-direct-sparse-solver-interface) for the particular meaning of each argument.


```julia
pardisoinit!(pt::Vector{Int},mtype::Integer,iparm::Vector{Int32})
```
Initializes Intel MKL PARDISO with default parameters depending on the matrix type.

```julia
pardiso!( pt::Vector{Int}, maxfct::Integer, mnum::Integer, mtype::Integer,
  phase::Integer, n::Integer, a::Vector{T}, ia::Vector{Int32},
  ja::Vector{Int32}, perm::Vector{Int32}, nrhs::Integer, iparm::Vector{Int32},
  msglvl::Integer, b::Vector{T}, x::Vector{T})::Int where T
```
Calculates the solution of a set of sparse linear equations with single or multiple right-hand sides and returns an integer error code. The type `T` has to match the chosen matrix type (`mtype` argument) and the provided options (`iparm` argument). The valid type `T` can be retrived with the `pardiso_data_type` function (see below).


```julia
pardiso_64!(pt::Vector{Int}, maxfct::Integer, mnum::Integer, mtype::Integer,
  phase::Integer, n::Integer, a::Vector{T}, ia::Vector{Int64},
  ja::Vector{Int64}, perm::Vector{Int64}, nrhs::Integer, iparm::Vector{Int64},
  msglvl::Integer, b::Vector{T}, x::Vector{T})::Int where T
```
64-bit integer version of `pardiso!`


```julia
pardiso_getdiag!(pt::Vector{Int}, df::Vector{T}, da::Vector{T}, mnum::Integer)::Int where T
```
Writes the diagonal elements of initial and factorized matrix in the provided vectors and returns an integer error code. The type `T` is as previously detailed for `pardiso!`.


```julia
pardiso_getdiag!(pt::Vector{Int}, df::Vector{T}, da::Vector{T}, mnum::Integer,
  mtype::Integer, iparm::Vector{<:Integer})::Int where T
```
Safer version of `pardiso_getdiag!` that cheks if the type `T` matches the given `mtype` and `iparm` arguments.

```julia
new_pardiso_handle()::Vector{Int}
```
Allocates and returns a vector that can be used as the `pt` argument in previous functions.

```julia
new_iparm()::Vector{Int32}
```
Allocates and returns a vector that can be used as the `iparm` argument in previous functions.


```julia
new_iparm_64()::Vector{Int64}
```
64-bit version of `new_iparm`. To be used in `pardiso_64!`

```julia
pardiso_data_type(mtype::Integer,iparm::Vector{<:Integer})::DataType
```
Returns the data type associated with the  matrix type `mtype` and the options in `iparm`.

