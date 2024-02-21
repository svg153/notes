cd $(mktemp -d)
pwd
gh clone-org --org pezaio --path .

my_contributions() {
  
  author=$(git config user.name)
  
  git log --author=${author} --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }' - >> ../log.txt
  git log --author=${author} --date=format:'%Y-%m-%d'  --pretty=format:"%h | %ad | %s" >> ../log.txt
}

for r in $(ls); do
  echo "repo: $r" >> log.txt
  cd $r
  my_contributions
  cd ..
done
