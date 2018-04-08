#!/bin/sh

set -e

is_on_top_of_master=$(git branch $(git rev-parse --abbrev-ref HEAD) --contains origin/master | wc -l)

if [ "${is_on_top_of_master}" -ne 1 ]; then
    echo "ERROR: This commit is not on top of master"
    echo "(no further validation is done due to this error)"
    exit 1
fi
