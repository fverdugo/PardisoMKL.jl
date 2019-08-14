using PardisoBindings
using Test
using SparseArrays

# Define linear system

mtype = 11

A = sparse([
  0. -2  3 0
  -2  4 -4 1
  -3  5  1 1
  1 -3 0 2 ])

n = A.n

b = MKL_FLOAT[1, 3, 2, 5]

x = zeros(MKL_FLOAT,n)

# Create the pardiso internal handler

pt = MKL_DSS_HANDLE()

# pardisoinit!

iparm = zeros(MKL_INT,64)

pardisoinit!(pt,mtype,iparm)

# pardiso! (solving the transpose of the system above)

maxfct = 1
mnum = 1
phase = 13
a = A.nzval
ia = Vector{MKL_INT}(A.colptr)
ja = Vector{MKL_INT}(A.rowval)
perm = zeros(MKL_INT,n)
nrhs = 1
msglvl = 0

err = pardiso!(
  pt,maxfct,mnum,mtype,phase,n,a,ia,ja,perm,nrhs,iparm,msglvl,b,x) 

tol = 1.0e-13

@test err == 0

@test maximum(abs.(A'*x-b)) < tol

# pardiso! (solving the system above)

iparm[12] = 2

err = pardiso!(
  pt,maxfct,mnum,mtype,phase,n,a,ia,ja,perm,nrhs,iparm,msglvl,b,x) 

@test maximum(abs.(A*x-b)) < tol

@test pardiso_data_type(mtype,iparm) == Float64


