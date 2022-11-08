#!/bin/env bash
# == stop rebase
#
# Create a branch from main and add commit.
# Than also add a commit to main.
# The commits conflicht with each other!
# Start a rebase with the new branch.
# The repository is now in the middle of a rebase with and error.


git clean -f
git checkout main
git reset origin/main --hard
for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
git clean -f
git delete -D topic/add_epilog

# Create the branch
git branch topic/add_epilog

# commit some stuff to main
git checkout main
echo "=== Epilog\n\nOb sich das wirklich so begeben hat, ist unwahrscheinlich.\n" > index.adoc
git add .
git commit -m "[story] add epilog" --author "Herr Krause <krause@fair-re-teller.com>"

# add to add_epilog
git checkout topic/add_epilog

echo "= Epilog\n\nOb sich das wirklich so begeben hat, ist unwahrscheinlich.\n" > chapters/epilog.adoc
git add .
git commit -m "[story] add start of epilog" --author "Herr Krause <krause@fair-re-teller.com>"


echo "== Epilog\n\ninclude::chapters/epilog.adoc[leveloffset=2]\n" >> index.adoc
git add .
git commit -m "[story] include epilog file" --author "Herr Krause <krause@fair-re-teller.com>"


# rebase
git rebase main

reset
