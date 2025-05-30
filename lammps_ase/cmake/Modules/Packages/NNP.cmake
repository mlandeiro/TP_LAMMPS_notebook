include(FindPackageHandleStandardArgs)

# Check if NNP_DIR is set manually.
if (DEFINED ENV{NNP_DIR})
  set(NNP_DIR "${NNP_DIR}")
# If not, try if directory "lib/hdnnp/nnp" exists.
else()
  get_filename_component(_fullpath "${LAMMPS_LIB_SOURCE_DIR}/nnp/nnp" REALPATH)
  if (EXISTS ${_fullpath})
    set(NNP_DIR "${_fullpath}")
  endif()
endif()

# Set path to include directory.
find_path(NNP_INCLUDE_DIR InterfaceLammps.h HINTS "${NNP_DIR}/include")
# Two libraries need to be linked: libnnp and libnnpif.
find_library(NNP_LIBNNP NAMES nnp HINTS "${NNP_DIR}/lib")
find_library(NNP_LIBNNPIF NAMES nnpif HINTS "${NNP_DIR}/lib")
# Users could compile nnp with extra flags which are then also required for
# pair_hdnnp.cpp compilation. To forward them to the LAMMPS build process nnp
# writes a file with cmake commands, e.g.
#
# target_compile_definitions(lammps PRIVATE -DNNP_NO_SF_GROUPS)
#
# to "lib/lammps-extra.cmake" which is then included by ML-HDNNP.cmake.
find_file(NNP_CMAKE_EXTRA NAMES lammps-extra.cmake HINTS "${NNP_DIR}/lib")

find_package_handle_standard_args(NNP DEFAULT_MSG
  NNP_DIR
  NNP_INCLUDE_DIR
  NNP_LIBNNP
  NNP_LIBNNPIF
  NNP_CMAKE_EXTRA)

if(NNP_FOUND)
  message("nnp found")
  message(${NNP_LIBNNPIF})
  message(${NNP_LIBNNP})
  if (NOT TARGET NNP::NNP)
    # nnp core library "libnnp"
    add_library(NNP::LIBNNP UNKNOWN IMPORTED)
    set_target_properties(NNP::LIBNNP PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES ${NNP_INCLUDE_DIR}
      IMPORTED_LOCATION ${NNP_LIBNNP})
    # nnp interface library "libnnpif"
    add_library(NNP::LIBNNPIF UNKNOWN IMPORTED)
    set_target_properties(NNP::LIBNNPIF PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES ${NNP_INCLUDE_DIR}
      IMPORTED_LOCATION ${NNP_LIBNNPIF})
    # Put libnnp, libnnpif and include directory together.
    add_library(NNP::NNP INTERFACE IMPORTED)
    set_property(TARGET NNP::NNP PROPERTY
      INTERFACE_LINK_LIBRARIES NNP::LIBNNPIF NNP::LIBNNP)
    set(NNP_CMAKE_EXTRAS ${NNP_CMAKE_EXTRA})
    target_link_libraries(lammps PRIVATE NNP::NNP)
  endif()
endif()

mark_as_advanced(
  NNP_DIR
  NNP_INCLUDE_DIR
  NNP_LIBNNP
  NNP_LIBNNPIF
  NNP_CMAKE_EXTRA
)
