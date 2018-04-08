#!/bin/sh

set -e

echo ""
echo "Validating commits"
echo ""

is-on-top-of-master.sh
echo "Branch is on top of master"

HOOKS_DIR=/git-hooks GIT_DIR=.git /git-hooks/check-commits.sh origin/master..HEAD
echo "Commit checks passed"
