#!/bin/env bash

# == Revert with conflict
# Nothing todo
git checkout main
git reset origin/main --hard
for b in `git branch | grep -v \*`; do git branch -D $b; done
git clean -f
