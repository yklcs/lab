#!/usr/bin/env bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

. $VENV/bin/activate

exec "$@"
