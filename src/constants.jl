
const MKL_INT = Int32

const _MKL_DSS_HANDLE_t = Ptr{Int64}

const MKL_DSS_HANDLE = Vector{Int64}

MKL_DSS_HANDLE() = zeros(Int64,64)

const MKL_FLOAT = Float64
