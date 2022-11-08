#!/bin/env bash
# == Wrong rebase reflog
#
# Create a 'master' branch based on initial commit and add a commit.
# Create a topic branch and add commits that only add files.
# This way the topic branch can be rebased on 'master'.
# Rebase the branch on master.

git checkout main
git reset origin/main --hard
for b in `git branch | grep -v \*`; do git branch -D $b; done
git clean -f

# create master
export init_commit=$(git rev-list HEAD | tail -n 1)
export init_date=$(git show -s --format=%ci ${init_commit})
git checkout -b master $(git rev-list HEAD | tail -n 1)

# commit to master
echo "\nThe main branch is master\n" >> REAMDE.md
git add .
git commit -m "first commit in master" --date "${init_date}"

# add branch and rebase
git checkout main

git checkout -b topic/add_prolog

echo "= Prolog\n\nDer Erzähler betritt die Bühne.\n" > chapters/prolog.adoc
git add .
git commit -m "[story] add start of prolog" --author "Herr Krause <krause@fair-re-teller.com>"


echo "= Erzähler\n\nDer Erzähler erzählt die Geschichte\n" > characters/story_teller.adoc
git add .
git commit -m "[story] add story teller character" --author "Herr Krause <krause@fair-re-teller.com>"

# prepare the reabse
git config rerere.enable true
rm -rf .git/rr-cache
cp -r ./scripts/rr-cache-p4 .git/rr-cache
git rebase master --rerere-autoupdate

# go through all the merge conflicts!
while [ -f .git/REBASE_HEAD ];
do
	git commit --no-edit
	git rebase --continue
done

git config rerere.enable false
rm -rf .git/rr-cache

reset
