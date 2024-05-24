#!/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

. $VENV/bin/activate
pip install $SRCDIR/pointops2
pip install $SRCDIR/simple-knn

exec "$@"
