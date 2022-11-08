#!/bin/env bash

# == Wrong branch commit
#
# Create a master branch based on first commit.
# Checkout the master branch.
# Add a commit.

git checkout main
git reset origin/main --hard
for b in `git branch | grep -v \*`; do git branch -D $b; done
git clean -f
git branch -D master || true

# create fake main (master)
export init_commit=$(git rev-list HEAD | tail -n 1)
export init_date=$(git show -s --format=%ci ${init_commit})
git checkout -b master $(git rev-list HEAD | tail -n 1)

# commit to master
echo "\nThe main branch is master\n" >> REAMDE.md
git add .
git commit -m "first commit in master" --date "${init_date}" --author "Nathan Hüsken <nathan@wintercloud.de>"

# add branch add master
git checkout -b topic/add_epilog

mkdir -p chapters
echo "= Epilog\n\nOb sich das wirklich so begeben hat, ist unwahrscheinlich.\n" > chapters/epilog.adoc
git add .
git commit -m "[story] add start of epilog" --author "Frau Hering <hering@fairy-re-teller.com>"

echo "== Epilog\n\ninclude::chapters/epilog.adoc[leveloffset=2]\n" >> index.adoc
git add .
git commit -m "[story] include epilog file" --author "Frau Hering <hering@fairy-re-teller.com>"

reset
