
function pardisoinit!(
  pt::MKL_DSS_HANDLE,
  mtype::Integer,
  iparm::Vector{Int32})

  ccall(
    pardisoinit_sym[],
    Cvoid, (
      _MKL_DSS_HANDLE_t,
      Ptr{Int32},
      Ptr{Int32}),
    pt,
    Ref(Int32(mtype)),
    iparm)

end

function pardiso!(
  pt::MKL_DSS_HANDLE,
  maxfct::Integer,
  mnum::Integer,
  mtype::Integer,
  phase::Integer,
  n::Integer,
  a::Vector{T},
  ia::Vector{Int32},
  ja::Vector{Int32},
  perm::Vector{Int32},
  nrhs::Integer,
  iparm::Vector{Int32},
  msglvl::Integer,
  b::Vector{T},
  x::Vector{T}) where T

  @assert T == pardiso_data_type(mtype,iparm)

  err = Ref(zero(Int32))

  ccall(
    pardiso_sym[],
    Cvoid, (
      _MKL_DSS_HANDLE_t,
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Cvoid},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Int32},
      Ptr{Cvoid},
      Ptr{Cvoid},
      Ptr{Int32}),
    pt,
    Ref(Int32(maxfct)),
    Ref(Int32(mnum)),
    Ref(Int32(mtype)),
    Ref(Int32(phase)),
    Ref(Int32(n)),
    a,
    ia,
    ja,
    perm,
    Ref(Int32(nrhs)),
    iparm,
    Ref(Int32(msglvl)),
    b,
    x,
    err)

  return Int(err[])

end

function pardiso_data_type(mtype::Integer,iparm::Vector{Int32})

  # Rules taken from
  # https://software.intel.com/en-us/mkl-developer-reference-fortran-pardiso-data-type

  T::DataType = Any

  if mtype in (1,2,-2,11)
    if iparm[28] == 0
      T = Float64
    else
      T = Float32
    end
  elseif mtype in (3,6,13,4,-4)
    if iparm[28] == 0
      T = Complex{Float64}
    else
      T = Complex{Float32}
    end
  else
    error("Unknown matrix type: mtype = $mtype")
  end

  T

end

