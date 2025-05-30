# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src/voro_build"
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src/voro_build-build"
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix"
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/tmp"
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src/voro_build-stamp"
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src"
  "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src/voro_build-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src/voro_build-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/landeiro/Documents/Enseignement/Doctorat/TP_2025/lammps/build/voro_build-prefix/src/voro_build-stamp${cfgdir}") # cfgdir has leading slash
endif()
