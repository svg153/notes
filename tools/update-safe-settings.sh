#!/bin/bash -eu

ORG_NAME=""
GH_ORG_NAME=""

if [ -z "${ORG_NAME}" ]; then
    echo "ORG_NAME is not set"
    exit 1
fi

if [ -z "${GH_ORG_NAME}" ]; then
    echo "GH_ORG_NAME is not set"
    exit 1
fi

APP_GH_ORG_NAME="github"
APP_GH_REPO_NAME="safe-settings"

deploypment_file=".github/workflows/deploy-app-${APP_GH_REPO_NAME}.yml"
deploypment_route_to_image=".jobs.deploy.with.deploy-images"

version=$(curl https://api.github.com/repos/${APP_GH_ORG_NAME}/${APP_GH_REPO_NAME}/releases/latest -s | jq .tag_name -r)
old_version=$(yq "${deploypment_route_to_image}" ${deploypment_file} | cut -d':' -f2 )

echo "${old_version}" == "${version}"

if [ "${old_version}" == "${version}" ]; then
    echo "No need to update"
    exit 0
fi
echo "New version: ${version}"

current_branch=$(git rev-parse --abbrev-ref HEAD)
there_are_changes=$(git diff-index --quiet HEAD --)
if [[ "${there_are_changes}" -eq 1 ]]; then
    git stash
fi

yq -i \
    "${deploypment_route_to_image} = \"docker.io/yadhav/${APP_GH_REPO_NAME}:${version}\"" \
    ${deploypment_file}

git diff -U0 \
    | grepdiff ${APP_GH_REPO_NAME} --output-matching=hunk \
    | git apply --cached --unidiff-zero

git sw main
git pull
git sw -c "apps/${APP_GH_REPO_NAME}/upgrade-to-${version}"
git commit -m "${ORG_NAME} ${APP_GH_REPO_NAME} to ${version}"
echo gh pr create \
    --title "Update ${APP_GH_REPO_NAME} to ${version} from ${ORG_NAME}" \
    --body "https://github.com/github/safe-settings/compare/${old_version}...${version}" \
    --base main
git restore ${deploypment_file}
git sw main
git pull --prune
git sw "${current_branch}"
if [ "${there_are_changes}" -eq 1 ]; then
    git stash pop
fi
