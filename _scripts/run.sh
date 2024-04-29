#!/usr/bin/env bash

set -euo pipefail

source $VENV/bin/activate

jupyter lab --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.tokenUnicode="" &
sleep infinity &

wait
exit $?
