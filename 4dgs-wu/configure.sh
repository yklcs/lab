#/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

. $VENV/bin/activate
cd 4dgs-wu
pip install submodules/depth-diff-gaussian-rasterization
pip install submodules/simple-knn
