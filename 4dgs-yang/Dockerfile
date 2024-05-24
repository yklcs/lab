ARG CUDA_IMAGE_TAG
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


ARG SRCDIR
ENV SRCDIR=$SRCDIR

RUN . $VENV/bin/activate && \
    pip install \
    torch==1.13.1 \
    torchaudio==0.13.1 \
    torchvision==0.14.1 \
    --index-url https://download.pytorch.org/whl/cu117

RUN . $VENV/bin/activate && \
    pip install \
    tqdm==4.66.1 \
    torchmetrics==0.11.4 \
    imagesize==1.4.1 \
    kornia==0.6.12 \
    omegaconf==2.3.0

COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
