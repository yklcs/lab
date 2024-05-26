#!/usr/bin/env python

"""
Diffs and applys patches for submodules.
"""

import os
import subprocess
from pathlib import Path
import argparse


Pathish = str | os.PathLike


def sh(cmd, *args, **kwargs):
    kwargs["check"] = True
    return subprocess.run(cmd, *args, **kwargs)


def diff(submodule: Pathish, patch: Pathish):
    submodule = Path(submodule).resolve()
    patch = Path(patch).resolve()

    git = ["git", "--no-pager", "-C", submodule]

    in_git_submodule = sh(
        [*git, "rev-parse", "--show-superproject-working-tree"],
        text=True,
        capture_output=True,
    )
    if in_git_submodule.stdout == "":
        raise Exception("not in git submodule")

    sh([*git, "add", "-N", "-A"])
    sh([*git, "diff", "origin/HEAD", "--output", patch])


def apply(submodule: Pathish, patch: Pathish, *, dry_run=False):
    submodule = Path(submodule).resolve()
    patch = Path(patch).resolve()

    git = ["git", "--no-pager", "-C", submodule]

    args = []
    if dry_run:
        args.append("--summary")

    sh([*git, "apply", *args, patch])


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)

    diff_parser = subparsers.add_parser("diff")
    diff_parser.add_argument("submodule", type=Path)
    diff_parser.add_argument("patch", type=Path)

    apply_parser = subparsers.add_parser("apply")
    apply_parser.add_argument("-C", "--dry-run", "--check", action="store_true")
    apply_parser.add_argument("submodule", type=Path)
    apply_parser.add_argument("patch", type=Path)

    args = parser.parse_args()

    if args.command == "diff":
        diff(args.submodule, args.patch)
    elif args.command == "apply":
        apply(args.submodule, args.patch, dry_run=args.dry_run)
