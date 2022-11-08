# == detached head with commit
#
# Create a detached head (at main) and add a commit (still in detached head).

#!/bin/env bash

git checkout main
git reset origin/main --hard
for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
git clean -f

git checkout main~0

echo "= Kapitel 6\n\nDer Jäger sah den Wolf und bekam Angst. Er Haute ab.\n\nRotkäppchen und Grossmutter wurden verdaut und die Geschichte ist aus.\n" > chapters/chapter6_alt.adoc

git add .
git commit -m "[story] add alternative chapter6" --author "Johannes <johannes@fair-re-teller.com>"

reset
