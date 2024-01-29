#!/bin/bash
# bash syntax function for current directory git repository
owners(){
  for f in $(git ls-files); do
    # filename
    echo -n "$f "
    # author emails if loc distribution >= 30%
    git fame -esnwMC --incl "$f" | tr '/' '|' \
      | awk -F '|' '(NR>6 && $6>=30) {print $2}' \
      | xargs echo
  done
}

# print to screen and file
owners | tee .github/CODEOWNERS
