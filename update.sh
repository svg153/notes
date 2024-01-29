for r in $(ls -1d */); do
    cd $r
    branch=$(git rev-parse --abbrev-ref HEAD)
    echo $r $branch
    if [ "${branch}" = "main" ]; then
        git pull --prune
    fi
    cd ..
done
