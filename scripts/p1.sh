#!/bin/env bash

# == Detached Head
#
# Bringt das repository in den Zustand eines "detached head"

git checkout main
git reset origin/main --hard
for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
git clean -f

git checkout HEAD~3
reset
