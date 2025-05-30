include(FindPackageHandleStandardArgs)

# Check if MILADY_DIR is set manually.
if (DEFINED ENV{MILADY_DIR})
  set(MILADY_DIR "${MILADY_DIR}")
else()
  get_filename_component(_fullpath "${LAMMPS_LIB_SOURCE_DIR}/milady" REALPATH)
  if (EXISTS ${_fullpath})
    set(MILADY_DIR "${_fullpath}")
  endif()
endif()

if (DEFINED ENV{MILADY_SRC_DIR})
  set(MILADY_SRC_DIR "${MILADY_SRC_DIR}")
else()
  get_filename_component(_fullpath "${LAMMPS_SOURCE_DIR}/MILADY" REALPATH)
  if (EXISTS ${_fullpath})
    set(MILADY_SRC_DIR "${_fullpath}")
  endif()
endif()

message(${MILADY_SRC_DIR})
# Two libraries need to be linked: libnnp and libnnpif.
find_library(MILADY_LIBMILADY NAMES milady HINTS "${MILADY_DIR}")

# target_compile_definitions(lammps PRIVATE -DMILADY_NO_SF_GROUPS)
#
# to "lib/lammps-extra.cmake" which is then included by ML-HDNNP.cmake.
#find_file(MILADY_CMAKE_EXTRA NAMES lammps-extra.cmake HINTS "${MILADY_DIR}")

find_package_handle_standard_args(MILADY DEFAULT_MSG
  MILADY_DIR
  MILADY_LIBMILADY)

if(MILADY_FOUND)
  message(found milady)
  if (NOT TARGET MILADY::MILADY)
    message(no target)
    add_library(MILADY::LIBMILADY UNKNOWN IMPORTED)
    set_target_properties(MILADY::LIBMILADY PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES ${MILADY_DIR}
      IMPORTED_LOCATION ${MILADY_LIBMILADY})
      # Put libnnp, libnnpif and include directory together.
    add_library(MILADY::MILADY UNKNOWN IMPORTED)
    set_target_properties(MILADY::MILADY PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES ${MILADY_SRC_DIR}
      IMPORTED_LOCATION ${MILADY_LIBMILADY})
    set_property(TARGET MILADY::MILADY PROPERTY
      INTERFACE_LINK_LIBRARIES MILADY::LIBMILADY)
    #set(MILADY_CMAKE_EXTRAS ${MILADY_CMAKE_EXTRA})
  endif()
endif()

mark_as_advanced(
  MILADY_DIR
  MILADY_LIBMILADY
  MILADY_CMAKE_EXTRA
)
