#!/bin/bash

###### Requirements

# gh: GitHub CLI is installed and configured
if ! command -v gh &> /dev/null; then
  echo "Error: gh is not installed. Please install it from https://cli.github.com/" >&2
  exit 1
fi
if ! gh auth status &> /dev/null; then
  echo "Error: gh is not configured. Please run 'gh auth login' to configure it." >&2
  exit 1
fi

###### Initialize variables

###### Function

# show_help: Show help message
function show_help() {
  echo "Usage: $0 -t <github_token> -o <organization> -i <team_id> -d <team_display_name>"
  echo "Options:"
  echo "  -t <github_token>             GitHub token"
  echo "  -o <organization>             GitHub organization"
  echo "  -i <team_id>                  External group team ID"
  echo "  -d <team_display_name>        External group team display name"
}

###### Main

# Parse arguments
while getopts "t:o:i:d:" opt; do
  case $opt in
    t) GH_TOKEN=$OPTARG ;;
    o) ORG=$OPTARG ;;
    i) external_group_team_id=$OPTARG ;;
    d) external_group_team_display_name=$OPTARG ;;
    *) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done

# Check if all variables are set and not empty
if [[ -z $GH_TOKEN || -z $ORG || -z $external_group_team_id || -z $external_group_team_display_name ]]; then
  echo "Error: Missing required arguments."
  show_help
  exit 1
fi

# Check if the external group team ID is a number
if ! [[ $external_group_team_id =~ ^[0-9]+$ ]]; then
  echo "Error: External group team ID must be a number."
  exit 1
fi

# Create a new team with external group team
# TODO: Check if this works
gh_field_external_group_team="team[external_group_team][$external_group_team_id][display_name]=$external_group_team_display_name"
gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /orgs/$ORG/teams \
    -f "team[name]=test-idp-gh" \
    -f "team[description]=A great team" \
    -f "${gh_field_external_group_team}" \
    -f "team[privacy]=secret" \
    -f "team[notification_setting]=notifications_disabled"
