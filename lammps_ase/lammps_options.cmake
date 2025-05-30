# FOR LAMMPS CMAKE BUILD
option(BUILD_SHARED_LIBS "Build shared library" ON)
option(BUILD_STATIC_LIBS "Build static library" ON)

# set installation location
set(CMAKE_INSTALL_PREFIX "$ENV{PREFIX}" CACHE BOOL "" FORCE)

# enforce c++11 standards
set(CCFLAGS -g -O3 -std=c++11)

# compile a binary and shared library
set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)

# allow error messages (very useful)
set(LAMMPS_EXCEPTIONS ON CACHE BOOL "" FORCE)

# minimal packages to run example (MANYBODY, EXTRA-FIX) and generate new pathway (REPLICA for "fix neb")
set(ALL_PACKAGES MANYBODY MEAM REPLICA VORONOI MEAM PYTHON )
#set(ALL_PACKAGES MANYBODY EXTRA-FIX MILADY REPLICA VORONOI MEAM NNP ML-SNAP PYTHON KSPACE)
#set(ALL_PACKAGES MANYBODY EXTRA-FIX REPLICA VORONOI MEAM NNP ML-SNAP PYTHON KSPACE) # Pour Sylvain 

foreach(PKG ${ALL_PACKAGES})
  set(PKG_${PKG} ON CACHE BOOL "" FORCE)
endforeach()
