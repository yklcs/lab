#!/bin/bash

set -euo pipefail

. $VENV/bin/activate

python ../_scripts/msr3d.py
mkdir -p 4dgs-wu/data/multipleview
mv msr3d-ballet 4dgs-wu/data/multipleview/
mv msr3d-breakdancers 4dgs-wu/data/multipleview/
rm -rf msr3d-raw msr3d.zip


if [ $COLMAP_CACHED ]; then
    cp colmap-out/msr3d-ballet/* 4dgs-wu/data/multipleview/msr3d-ballet
    cp colmap-out/msr3d-breakdancers/* 4dgs-wu/data/multipleview/msr3d-breakdancers
else
    cd 4dgs-wu
    chmod +x multipleviewprogress.sh
    ./multipleviewprogress.sh msr3d-ballet
    rm -rf colmap_tmp
    ./multipleviewprogress.sh msr3d-breakdancers
    rm -rf colmap_tmp
fi

# python train.py -s data/multipleview/msr3d-ballet --port 6017 --expname "multipleview/msr3d-ballet" --configs arguments/multipleview/default.py
