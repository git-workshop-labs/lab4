
#!/bin/env bash

# == Undo Reset with reflog
#
# Create a branch. Commit to it.
# Reset it on main (hard).

git clean -f
git checkout main
git reset origin/main --hard
for b in `git branch | grep -v \*`; do git branch -D $b; done
git branch -D topic/add_epilog || true

# add branch add master
git checkout -b topic/add_epilog

echo "= Epilog\n\nOb sich das wirklich so begeben hat, ist unwahrscheinlich.\n" > chapters/epilog.adoc
git add .
git commit -m "[story] add start of epilog" --author "Herr Krause <krause@fairy-re-teller.com>"

echo "== Epilog\n\ninclude::chapters/epilog.adoc[leveloffset=2]\n" >> index.adoc
git add .
git commit -m "[story] include epilog file" --author "Herr Krause <krause@fairy-re-teller.com>"

# reset

git reset --hard main

reset
