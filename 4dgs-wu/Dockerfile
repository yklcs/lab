ARG CUDA_IMAGE_TAG=11.8.0-cudnn8-devel-ubuntu22.04
ARG PYTHON=python3.10
ARG DEBIAN_FRONTEND=noninteractive

FROM nvidia/cuda:$CUDA_IMAGE_TAG


ENV VENV=/venv


RUN apt update && apt upgrade -y && \
    apt install git curl build-essential


# python

RUN apt install -y \
    $PYTHON $PYTHON-venv && \
    $PYTHON -m venv $VENV


# colmap

RUN apt install -y \
    cmake \
    ninja-build \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev \
    gcc-10 \
    g++-10 && \
    git clone https://github.com/colmap/colmap.git && \
    cd colmap && mkdir build && cd build && \
    cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES=86 \
    -DCMAKE_CUDA_HOST_COMPILER=g++-10 \
    -DCMAKE_CXX_COMPILER=g++-10 \
    -DCMAKE_C_COMPILER=gcc-10 && \
    ninja && ninja install && \
    rm -rf colmap


# 4dgs-wu

RUN cd 4DGaussians && \
    . $VENV/bin/activate && \
    $PYTHON -m pip install -r requirements.txt && \
    $PYTHON -m pip install -e submodules/depth-diff-gaussian-rasterization \
    $PYTHON -m pip install -e submodules/simple-knn


ENTRYPOINT [ "/bin/sh", "-c" ]
