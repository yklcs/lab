#!/usr/bin/env bash

set -euo pipefail

source $VENV/bin/activate

jupyter lab &
sleep infinity &

wait
exit $?
