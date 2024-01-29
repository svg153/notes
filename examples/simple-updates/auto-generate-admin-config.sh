#!/bin/bash -x

# generate admin config for simple-updates
# config:
#   labels:
#     - dependencies
#   schedule:
#     interval: "weekly"
#     day: "wednesday"
# groups:
#   - package-ecosystem: github-actions
#     repos:
#       admin: <list_of_folders_in_actions>

file_path=./admin.yaml

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# generate the list_of_folders_in_actions
actions_dir="${SCRIPT_DIR}/../../actions/"
list_of_folders_in_actions=( $(ls -1d ${actions_dir}*/ | xargs -n 1 basename) )

# generate the admin.yaml file
cat <<EOF > ${file_path}
labels:
  - dependencies
schedule:
  interval: "weekly"
  day: "wednesday"
groups:
  - package-ecosystem: github-actions
    repos:
      admin: ${list_of_folders_in_actions[@]}
EOF
