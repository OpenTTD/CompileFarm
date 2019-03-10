#!/bin/sh

set -e

if [ -z "${TARGET_BRANCH}" ]; then
	TARGET_BRANCH=master
fi

is_on_top_of_master=$(git branch $(git rev-parse --abbrev-ref HEAD) --contains origin/${TARGET_BRANCH} | wc -l)

if [ "${is_on_top_of_master}" -ne 1 ]; then
    echo "ERROR: This commit is not on top of ${TARGET_BRANCH}"
    echo "(no further validation is done due to this error)"
    exit 1
fi
