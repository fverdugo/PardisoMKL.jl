
function pardisoinit!(
  pt::MKL_DSS_HANDLE,
  mtype::Integer,
  iparm::Vector{MKL_INT})

  ccall(
    pardisoinit_sym[],
    Cvoid, (
      _MKL_DSS_HANDLE_t,
      Ptr{MKL_INT},
      Ptr{MKL_INT}),
    pt,
    Ref(MKL_INT(mtype)),
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
  ia::Vector{MKL_INT},
  ja::Vector{MKL_INT},
  perm::Vector{MKL_INT},
  nrhs::Integer,
  iparm::Vector{MKL_INT},
  msglvl::Integer,
  b::Vector{T},
  x::Vector{T}) where T

  _check_value_type(T,mtype)

  err = Ref(zero(MKL_INT))

  ccall(
    pardiso_sym[],
    Cvoid, (
      _MKL_DSS_HANDLE_t,
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{Cvoid},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{MKL_INT},
      Ptr{Cvoid},
      Ptr{Cvoid},
      Ptr{MKL_INT}),
    pt,
    Ref(MKL_INT(maxfct)),
    Ref(MKL_INT(mnum)),
    Ref(MKL_INT(mtype)),
    Ref(MKL_INT(phase)),
    Ref(MKL_INT(n)),
    a,
    ia,
    ja,
    perm,
    Ref(MKL_INT(nrhs)),
    iparm,
    Ref(MKL_INT(msglvl)),
    b,
    x,
    err)

  return Int(err[])

end

function _check_value_type(::Type{T},mtype) where T
  @assert T == MKL_FLOAT
end
