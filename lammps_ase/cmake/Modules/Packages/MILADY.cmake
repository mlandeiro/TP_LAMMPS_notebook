enable_language(Fortran)
find_package(BLAS REQUIRED)
find_package(LAPACK REQUIRED)
find_library(MILADY_LIBMILADY NAMES milady HINTS "${LAMMPS_LIB_SOURCE_DIR}/milady/")
message(${MILADY_LIBMILADY})

find_package(MILADY)
target_link_libraries(lammps PRIVATE MILADY::MILADY lapack blas)

