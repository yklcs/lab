ARG CUDA_IMAGE_TAG=11.7.1-cudnn8-devel-ubuntu22.04
FROM nvcr.io/nvidia/cuda:$CUDA_IMAGE_TAG


ARG DEBIAN_FRONTEND=noninteractive


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
    libceres-dev
ARG COLMAP_BRANCH=main
RUN git clone https://github.com/colmap/colmap.git --branch $COLMAP_BRANCH && \
    cd colmap && mkdir build && cd build && \
    cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES="$CUDA_ARCHITECTURES" && \
    ninja && ninja install && \
    cd ../.. && \
    rm -rf colmap


# python

ENV VENV=/venv
ARG PYTHON=python3.10
RUN apt install -y \
    $PYTHON "$PYTHON-venv" "$PYTHON-dev" "$PYTHON-tk" && \
    $PYTHON -m venv $VENV


ARG WORKDIR
WORKDIR $WORKDIR

COPY 4dgs-wu $WORKDIR/4dgs-wu
RUN cd $WORKDIR/4dgs-wu && \
    . $VENV/bin/activate && \
    pip install -r requirements.txt && \
    pip install scikit-image


# jupyterlab
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt install -y nodejs && \
    . $VENV/bin/activate && \
    pip install jupyterlab ipykernel && \
    python -m ipykernel install --user --name=venv && \
    NODE_OPTIONS=--openssl-legacy-provider jupyter lab build


ENTRYPOINT [ "/bin/sh", "-c" ]
