#!/usr/bin/env bash

set -euo pipefail

source $VENV/bin/activate

sleep infinity &

wait
exit $?
