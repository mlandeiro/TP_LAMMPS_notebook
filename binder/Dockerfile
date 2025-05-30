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
    git \
    unzip

# 2. Installer OneAPI (Intel compilers)
RUN wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19116/l_BaseKit_p_2024.0.0.49518_offline.sh && \
    chmod +x l_BaseKit_p_2024.0.0.49518_offline.sh && \
    ./l_BaseKit_p_2024.0.0.49518_offline.sh -s -a --silent --eula accept && \
    rm l_BaseKit_p_2024.0.0.49518_offline.sh

ENV ONEAPI_ROOT=/opt/intel/oneapi
ENV PATH="$ONEAPI_ROOT/compiler/latest/linux/bin:$PATH"
ENV LD_LIBRARY_PATH="$ONEAPI_ROOT/compiler/latest/linux/lib:$LD_LIBRARY_PATH"
ENV CC=icx
ENV CXX=icpx

USER jovyan

# 3. Copier votre propre répertoire LAMMPS
COPY lammps /home/jovyan/lammps_ase

# 4. Compiler avec OneAPI (dans /home/jovyan/lammps/build déjà préparé)
RUN cd /home/jovyan/lammps_ase/build && \
    ./cmake_save_line && \
    make -j$(nproc) && \
    make install

ENV PATH="/home/jovyan/lammps_ase/install/bin:$PATH"

