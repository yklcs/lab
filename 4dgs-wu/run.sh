#!/usr/bin/env bash

set -euo pipefail

jupyter lab &
sleep infinity &

wait -n
exit $?
