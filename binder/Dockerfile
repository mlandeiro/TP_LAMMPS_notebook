FROM jupyter/scipy-notebook

USER root

# 1. Installer dépendances système
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    wget \
    gnupg \
    libffi-dev \
    libnuma-dev \
    libopenmpi-dev \
    gfortran \
    libfftw3-dev \
    openmpi-bin \
    git \
    unzip


USER jovyan

# 3. Copier votre propre répertoire LAMMPS
COPY lammps_ase /home/jovyan/lammps_ase

# 4. Compiler avec OneAPI (dans /home/jovyan/lammps/build déjà préparé)
RUN cd /home/jovyan/lammps_ase/build && \
    rm -r * &&\
    cp ../cmake_save_line .&&\
    chmod +x cmake_save_line && \
    ./cmake_save_line && \
    make -j$(nproc) && \


