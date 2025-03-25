#!/bin/bash
# filepath: repo-config-comparison.sh

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    echo "https://cli.github.com/manual/installation"
    exit 1
fi

# Check if gh is authenticated
if ! gh auth status &> /dev/null; then
    echo "Please login to GitHub first using: gh auth login"
    exit 1
fi

# Check if jq is installed (needed for JSON processing)
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install it first."
    echo "Run: sudo apt-get install jq"
    exit 1
fi

# Validate input parameters
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <repo1> <repo2> [existing_data_directory]"
    echo "Example: $0 RUNA/shared-github-actions RUNA/argocd-multitenant-applications"
    echo "Example using existing data: $0 RUNA/shared-github-actions RUNA/argocd-multitenant-applications repo-comparison-20230615-120000"
    exit 1
fi

REPO1=$1
REPO2=$2
USING_EXISTING_DATA=false
EXISTING_DATA_DIR=""

if [ $# -eq 3 ]; then
    EXISTING_DATA_DIR=$3
    
    # Check if the provided directory exists
    if [ ! -d "$EXISTING_DATA_DIR" ]; then
        echo "Error: The specified directory '$EXISTING_DATA_DIR' does not exist."
        exit 1
    fi
    
    # Check if the directory contains the expected repository data
    if [ ! -d "${EXISTING_DATA_DIR}/${REPO1}" ] || [ ! -d "${EXISTING_DATA_DIR}/${REPO2}" ]; then
        echo "Error: The specified directory does not contain data for both repositories."
        echo "Expected to find subdirectories for ${REPO1} and ${REPO2}"
        exit 1
    fi
    
    # Set flag to use existing data
    USING_EXISTING_DATA=true
    OUTPUT_DIR="${EXISTING_DATA_DIR}"
else
    OUTPUT_DIR="repo-comparison-$(date +%Y%m%d-%H%M%S)"

    # Create output directory
    mkdir -p "${OUTPUT_DIR}/${REPO1}"
    mkdir -p "${OUTPUT_DIR}/${REPO2}"
fi


# Helper function to call GitHub API and handle errors
gh_api_call() {
    local endpoint=$1
    local output_file=$2
    
    if gh api "$endpoint" > "$output_file" 2>/dev/null; then
        echo "✓ Successfully fetched: $endpoint"
        return 0
    else
        echo "✗ Error fetching: $endpoint"
        echo "{\"error\": \"API call failed\"}" > "$output_file"
        return 1
    fi
}

# Check if repository exists
check_repo_exists() {
    local repo=$1
    if gh api "repos/${repo}" &>/dev/null; then
        echo "✓ Repository ${repo} exists"
        return 0
    else
        echo "✗ Repository ${repo} does not exist or you don't have access to it"
        return 1
    fi
}

fetch_repo_config() {
    local repo=$1
    local output_dir="${OUTPUT_DIR}/${repo}"
    
    echo "Fetching configuration for ${repo}..."
    
    # Check if repository exists before proceeding
    if ! check_repo_exists "${repo}"; then
        echo "Skipping further API calls for non-existent repository: ${repo}"
        echo "{\"error\": \"Repository does not exist or inaccessible\"}" > "${output_dir}/repo-error.json"
        return 1
    fi
    
    # Repository details
    gh_api_call "repos/${repo}" "${output_dir}/repo-details.json"
    
    # Branch protection rules
    gh_api_call "repos/${repo}/branches?protected=true" "${output_dir}/protected-branches.json"
    
    # For each protected branch, get protection settings
    if [ -f "${output_dir}/protected-branches.json" ] && ! grep -q "error" "${output_dir}/protected-branches.json"; then
        for branch in $(jq -r '.[].name // empty' "${output_dir}/protected-branches.json" 2>/dev/null || echo ""); do
            if [ ! -z "$branch" ]; then
                gh_api_call "repos/${repo}/branches/${branch}/protection" "${output_dir}/branch-${branch}-protection.json"
            fi
        done
    fi
    
    # Webhooks
    gh_api_call "repos/${repo}/hooks" "${output_dir}/webhooks.json"
    
    # Actions permissions
    gh_api_call "repos/${repo}/actions/permissions" "${output_dir}/actions-permissions.json"
    
    # Environments
    gh_api_call "repos/${repo}/environments" "${output_dir}/environments.json"
    
    # List all environments and their details
    if [ -f "${output_dir}/environments.json" ] && ! grep -q "error" "${output_dir}/environments.json"; then
        for env in $(jq -r '.environments[].name // empty' "${output_dir}/environments.json" 2>/dev/null || echo ""); do
            if [ ! -z "$env" ]; then
                gh_api_call "repos/${repo}/environments/${env}" "${output_dir}/environment-${env}.json"
            fi
        done
    fi
    
    # Repository topics
    gh_api_call "repos/${repo}/topics" "${output_dir}/topics.json"
    
    # Teams with access
    gh_api_call "repos/${repo}/teams" "${output_dir}/teams.json"
    
    # Collaborators 
    gh_api_call "repos/${repo}/collaborators" "${output_dir}/collaborators.json"
    
    # Repository variables
    gh_api_call "repos/${repo}/actions/variables" "${output_dir}/variables.json"
    
    # Repository secrets (only names, not values)
    gh_api_call "repos/${repo}/actions/secrets" "${output_dir}/secrets.json"
}

# Fetch configurations or use existing data
if [ "$USING_EXISTING_DATA" = true ]; then
    echo "Using existing repository data from ${OUTPUT_DIR}"
else
    echo "Fetching repository configurations..."
    echo "This may take a few moments..."
    
    # Fetch configurations for both repositories
    fetch_repo_config "${REPO1}"
    fetch_repo_config "${REPO2}"
fi

# Create a summary comparison file
echo "Creating summary comparison report..."
{
    echo "# Repository Configuration Comparison"
    echo
    echo "## Comparing ${REPO1} vs ${REPO2}"
    echo
    echo "Generated on $(date)"
    echo
    
    # Check if repositories exist before proceeding with comparison
    REPO1_EXISTS=true
    REPO2_EXISTS=true
    
    if [ -f "${OUTPUT_DIR}/${REPO1}/repo-error.json" ]; then
        echo "⚠️ **WARNING**: Repository ${REPO1} does not exist or is inaccessible"
        REPO1_EXISTS=false
    fi
    
    if [ -f "${OUTPUT_DIR}/${REPO2}/repo-error.json" ]; then
        echo "⚠️ **WARNING**: Repository ${REPO2} does not exist or is inaccessible"
        REPO2_EXISTS=false
    fi
    
    if [ "$REPO1_EXISTS" = false ] && [ "$REPO2_EXISTS" = false ]; then
        echo "Both repositories are inaccessible. No comparison can be made."
        echo "Please verify the repository names and your access permissions."
        exit 1
    fi
    
    echo "## Basic Repository Information"
    echo
    echo "| Feature | ${REPO1} | ${REPO2} |"
    echo "|---------|----------|----------|"
    
    # Compare visibility
    REPO1_VISIBILITY=$(jq -r '.visibility // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_VISIBILITY=$(jq -r '.visibility // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Visibility | ${REPO1_VISIBILITY} | ${REPO2_VISIBILITY} |"
    
    # Compare default branch
    REPO1_DEFAULT_BRANCH=$(jq -r '.default_branch // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_DEFAULT_BRANCH=$(jq -r '.default_branch // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Default Branch | ${REPO1_DEFAULT_BRANCH} | ${REPO2_DEFAULT_BRANCH} |"
    
    # Compare protected branches count
    REPO1_PROT_BRANCHES=$(jq 'if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO1}/protected-branches.json" 2>/dev/null || echo "0")
    REPO2_PROT_BRANCHES=$(jq 'if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO2}/protected-branches.json" 2>/dev/null || echo "0")
    echo "| Protected Branches | ${REPO1_PROT_BRANCHES} | ${REPO2_PROT_BRANCHES} |"
    
    # Compare webhooks count
    REPO1_WEBHOOKS=$(jq 'if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO1}/webhooks.json" 2>/dev/null || echo "0")
    REPO2_WEBHOOKS=$(jq 'if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO2}/webhooks.json" 2>/dev/null || echo "0")
    echo "| Webhooks | ${REPO1_WEBHOOKS} | ${REPO2_WEBHOOKS} |"
    
    # Compare environments count
    REPO1_ENV_COUNT=$(jq '.environments | if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO1}/environments.json" 2>/dev/null || echo "0")
    REPO2_ENV_COUNT=$(jq '.environments | if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO2}/environments.json" 2>/dev/null || echo "0")
    echo "| Environments | ${REPO1_ENV_COUNT} | ${REPO2_ENV_COUNT} |"
    
    # Compare teams count
    REPO1_TEAMS=$(jq 'if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO1}/teams.json" 2>/dev/null || echo "0")
    REPO2_TEAMS=$(jq 'if type == "array" then length else 0 end' "${OUTPUT_DIR}/${REPO2}/teams.json" 2>/dev/null || echo "0")
    echo "| Teams | ${REPO1_TEAMS} | ${REPO2_TEAMS} |"
    
    # Compare secrets count
    REPO1_SECRETS=$(jq '.total_count // 0' "${OUTPUT_DIR}/${REPO1}/secrets.json" 2>/dev/null || echo "0")
    REPO2_SECRETS=$(jq '.total_count // 0' "${OUTPUT_DIR}/${REPO2}/secrets.json" 2>/dev/null || echo "0")
    echo "| Secrets | ${REPO1_SECRETS} | ${REPO2_SECRETS} |"
    
    # Compare variables count
    REPO1_VARS=$(jq '.total_count // 0' "${OUTPUT_DIR}/${REPO1}/variables.json" 2>/dev/null || echo "0")
    REPO2_VARS=$(jq '.total_count // 0' "${OUTPUT_DIR}/${REPO2}/variables.json" 2>/dev/null || echo "0")
    echo "| Variables | ${REPO1_VARS} | ${REPO2_VARS} |"
    
    # Compare additional repository details
    echo
    echo "## Repository Details Comparison"
    echo
    echo "| Setting | ${REPO1} | ${REPO2} |"
    echo "|---------|----------|----------|"
    
    # Compare description
    REPO1_DESC=$(jq -r '.description // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_DESC=$(jq -r '.description // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Description | ${REPO1_DESC} | ${REPO2_DESC} |"
    
    # Compare allow merge commit
    REPO1_MERGE=$(jq -r '.allow_merge_commit // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_MERGE=$(jq -r '.allow_merge_commit // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Allow Merge Commit | ${REPO1_MERGE} | ${REPO2_MERGE} |"
    
    # Compare allow squash merge
    REPO1_SQUASH=$(jq -r '.allow_squash_merge // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_SQUASH=$(jq -r '.allow_squash_merge // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Allow Squash Merge | ${REPO1_SQUASH} | ${REPO2_SQUASH} |"
    
    # Compare allow rebase merge
    REPO1_REBASE=$(jq -r '.allow_rebase_merge // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_REBASE=$(jq -r '.allow_rebase_merge // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Allow Rebase Merge | ${REPO1_REBASE} | ${REPO2_REBASE} |"
    
    # Compare delete branch on merge
    REPO1_DELETE=$(jq -r '.delete_branch_on_merge // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_DELETE=$(jq -r '.delete_branch_on_merge // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Delete Branch on Merge | ${REPO1_DELETE} | ${REPO2_DELETE} |"
    # Compare issues enabled
    REPO1_ISSUES=$(jq -r '.has_issues // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_ISSUES=$(jq -r '.has_issues // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Issues Enabled | ${REPO1_ISSUES} | ${REPO2_ISSUES} |"
    
    # Compare wiki enabled
    REPO1_WIKI=$(jq -r '.has_wiki // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_WIKI=$(jq -r '.has_wiki // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Wiki Enabled | ${REPO1_WIKI} | ${REPO2_WIKI} |"
    
    # Compare discussions enabled
    REPO1_DISCUSSIONS=$(jq -r '.has_discussions // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_DISCUSSIONS=$(jq -r '.has_discussions // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Discussions Enabled | ${REPO1_DISCUSSIONS} | ${REPO2_DISCUSSIONS} |"
    
    # Compare projects enabled
    REPO1_PROJECTS=$(jq -r '.has_projects // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_PROJECTS=$(jq -r '.has_projects // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Projects Enabled | ${REPO1_PROJECTS} | ${REPO2_PROJECTS} |"
    
    # Compare auto merge enabled
    REPO1_AUTO_MERGE=$(jq -r '.allow_auto_merge // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_AUTO_MERGE=$(jq -r '.allow_auto_merge // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Auto Merge Enabled | ${REPO1_AUTO_MERGE} | ${REPO2_AUTO_MERGE} |"
    
    # Compare if template
    REPO1_IS_TEMPLATE=$(jq -r '.is_template // "N/A"' "${OUTPUT_DIR}/${REPO1}/repo-details.json" 2>/dev/null || echo "N/A")
    REPO2_IS_TEMPLATE=$(jq -r '.is_template // "N/A"' "${OUTPUT_DIR}/${REPO2}/repo-details.json" 2>/dev/null || echo "N/A")
    echo "| Is Template | ${REPO1_IS_TEMPLATE} | ${REPO2_IS_TEMPLATE} |"
    
    
    echo
    echo "## Protected Branches Comparison"
    echo
    echo "### ${REPO1} Protected Branches"
    echo
    if [ -f "${OUTPUT_DIR}/${REPO1}/protected-branches.json" ]; then
        echo "Protected branches found:"
        echo
        for branch in $(jq -r '.[].name' "${OUTPUT_DIR}/${REPO1}/protected-branches.json" 2>/dev/null || echo ""); do
            echo "- ${branch}"
        done
    else
        echo "No protected branches found."
    fi
    
    echo
    echo "### ${REPO2} Protected Branches"
    echo
    if [ -f "${OUTPUT_DIR}/${REPO2}/protected-branches.json" ]; then
        echo "Protected branches found:"
        echo
        for branch in $(jq -r '.[].name' "${OUTPUT_DIR}/${REPO2}/protected-branches.json" 2>/dev/null || echo ""); do
            echo "- ${branch}"
        done
    else
        echo "No protected branches found."
    fi
    
    echo
    echo "## Environments Comparison"
    echo
    echo "### ${REPO1} Environments"
    echo
    if [ -f "${OUTPUT_DIR}/${REPO1}/environments.json" ] && jq -e '.environments | length > 0' "${OUTPUT_DIR}/${REPO1}/environments.json" &>/dev/null; then
        echo "Environments found:"
        echo
        for env in $(jq -r '.environments[].name' "${OUTPUT_DIR}/${REPO1}/environments.json" 2>/dev/null || echo ""); do
            echo "- ${env}"
        done
    else
        echo "No environments found."
    fi
    
    echo
    echo "### ${REPO2} Environments"
    echo
    if [ -f "${OUTPUT_DIR}/${REPO2}/environments.json" ] && jq -e '.environments | length > 0' "${OUTPUT_DIR}/${REPO2}/environments.json" &>/dev/null; then
        echo "Environments found:"
        echo
        for env in $(jq -r '.environments[].name' "${OUTPUT_DIR}/${REPO2}/environments.json" 2>/dev/null || echo ""); do
            echo "- ${env}"
        done
    else
        echo "No environments found."
    fi

    echo
    echo "## GitHub Actions Settings Comparison"
    echo
    echo "| Setting | ${REPO1} | ${REPO2} |"
    echo "|---------|----------|----------|"
    
    # Compare GitHub Actions enabled status
    REPO1_ACTIONS_ENABLED=$(jq -r '.enabled' "${OUTPUT_DIR}/${REPO1}/actions-permissions.json" 2>/dev/null || echo "N/A")
    REPO2_ACTIONS_ENABLED=$(jq -r '.enabled' "${OUTPUT_DIR}/${REPO2}/actions-permissions.json" 2>/dev/null || echo "N/A")
    echo "| Actions Enabled | ${REPO1_ACTIONS_ENABLED} | ${REPO2_ACTIONS_ENABLED} |"
    
    echo
    echo "## Full comparison details available in: ${OUTPUT_DIR}/"
    echo
    echo "Use a tool like 'diff' or 'meld' to compare the JSON files for detailed differences."

} > "${OUTPUT_DIR}/comparison-summary.md"

echo "Comparison complete!"
echo "Detailed results saved to: ${OUTPUT_DIR}/"
echo "Summary report: ${OUTPUT_DIR}/comparison-summary.md"