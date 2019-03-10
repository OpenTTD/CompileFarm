#!/bin/sh

set -e

echo ""
echo "Validating commits"
echo ""

if [ -z "${TARGET_BRANCH}" ]; then
	TARGET_BRANCH=master
fi

is-on-top-of-master.sh
echo "Branch is on top of ${TARGET_BRANCH}"

HOOKS_DIR=/git-hooks GIT_DIR=.git /git-hooks/check-commits.sh origin/${TARGET_BRANCH}..HEAD
echo "Commit checks passed"
