module PardisoBindings

using Libdl

include("load_mkl.jl")

deps_jl = joinpath(@__DIR__, "..", "deps", "deps.jl")

if !isfile(deps_jl)
  s = """
  Package PardisoBindings not installed properly.
  """
  error(s)
end

include(deps_jl)

const pardisoinit = Ref{Ptr}()
const pardiso = Ref{Ptr}()
const pardiso_getenv = Ref{Ptr}()
const pardiso_setenv = Ref{Ptr}()
const pardiso_getdiag = Ref{Ptr}()
const pardiso_export = Ref{Ptr}()
const pardiso_handle_store = Ref{Ptr}()
const pardiso_handle_restore = Ref{Ptr}()
const pardiso_handle_delete = Ref{Ptr}()
const MKL_PARDISO_LOADED = Ref(false)

function __init__()

  libmkl = load_mkl_gcc(mkllibdir,gcclibdir)

  pardisoinit[] = Libdl.dlsym(libmkl,:pardisoinit)
  pardiso[] = Libdl.dlsym(libmkl,:pardiso )
  pardiso_getenv[] = Libdl.dlsym(libmkl,:pardiso_getenv)
  pardiso_setenv[] = Libdl.dlsym(libmkl,:pardiso_setenv)
  pardiso_getdiag[] = Libdl.dlsym(libmkl,:pardiso_getdiag)
  pardiso_export[] = Libdl.dlsym(libmkl,:pardiso_export)
  pardiso_handle_store[] = Libdl.dlsym(libmkl,:pardiso_handle_store)
  pardiso_handle_restore[] = Libdl.dlsym(libmkl,:pardiso_handle_restore)
  pardiso_handle_delete[] = Libdl.dlsym(libmkl,:pardiso_handle_delete)

  MKL_PARDISO_LOADED[] = true

end

end # module
