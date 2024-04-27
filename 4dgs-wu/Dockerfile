ARG CUDA_IMAGE_TAG=11.7.1-cudnn8-devel-ubuntu22.04
FROM nvcr.io/nvidia/cuda:$CUDA_IMAGE_TAG


ARG PYTHON=python3.10
ARG DEBIAN_FRONTEND=noninteractive

ENV VENV=/venv


RUN apt update && apt upgrade -y && \
    apt install -y git curl unzip build-essential


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
    libceres-dev && \
    git clone https://github.com/colmap/colmap.git && \
    cd colmap && mkdir build && cd build && \
    cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES=native && \
    ninja && ninja install && \
    cd ../.. && \
    rm -rf colmap


# python

RUN apt install -y \
    $PYTHON "$PYTHON-venv" "$PYTHON-dev" && \
    $PYTHON -m venv $VENV


# 4dgs-wu


COPY 4dgs-wu $WORKDIR


RUN cd $WORKDIR && \
    . $VENV/bin/activate && \
    $PYTHON -m pip install -r requirements.txt


ENTRYPOINT [ "/bin/sh", "-c" ]
