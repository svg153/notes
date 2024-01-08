# !/bin/bash

ORG_NAME=
org=<https://dev.azure.com/$ORG_NAME>
project=""
board=""
queryId=""

if [ -z "$ORG_NAME" ] || [ -z "$project" ] || [ -z "$board" ] || [ -z "$queryId" ]; then
    echo "Please set ORG_NAME, project, board and queryId"
    exit 1
fi

az boards query --id $queryId -p $project --org $org -o json

az boards area project show --id ??? --org $org -p $project -o json

az boards iteration project list \
    --org $org \
    --project $project \
    -o json | jq -r '.children|.[]|.identifier'

children=$(jq -r '.children|.[]|.identifier' out.json)

# list all work items in the iteration

az boards iteration team \
    list-work-items \
    --org $org \
    --project $project \
    --team "Team 1" \
    --id "Sprint 1" \
    -o json > iteration.json

jq -r '.workItemRelations.[].target.id' iteration.json
jq -r '.workItemRelations.[].target.url' iteration.json

az boards work-item show \
    --org $org \
    --project $project \
    --id 738 \
    -o json > item.json
