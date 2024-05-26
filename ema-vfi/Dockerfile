ARG CUDA_IMAGE_TAG
FROM nvcr.io/nvidia/cuda:$CUDA_IMAGE_TAG


ARG DEBIAN_FRONTEND=noninteractive


RUN apt update && apt upgrade -y && \
    apt install -y git curl unzip build-essential

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
    tqdm \
    timm \
    numpy \
    opencv-python \
    scikit-image

COPY entrypoint.sh .
ENTRYPOINT [ "./entrypoint.sh" ]
