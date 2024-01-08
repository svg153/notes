# Common github

- <https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file>
- <https://sourcegraph.com/search?q=context:global+repo:.*/.github&patternType=literal&case=yes>
- <https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests>
- [!!!! Make sure the repository status is set to Public (a repository for default files cannot be private).](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file)

## Projects beta

- Github Action to autoamte: https://github.com/leonsteinhaeuser/project-beta-automations (from https://github.com/alex-page/github-project-automation-plus/issues/76)
- 

## github as code

- https://github.com/github/safe-settings
- https://github.com/cloudalchemy/auto-maintenance/tree/master
- 

## ISSUE_TEMPLATE and PR_TEMPLATE

Add template to all repos: ## .github/ISSUE_TEMPLATE/user-story.md

- Validate pull request title
  - https://sourcegraph.com/github.com/terraform-aws-modules/terraform-aws-eks/-/blob/.github/workflows/pr-title.yml

### Info

#### .github repo examples

- Ohh GOD!!!
  - [npm](https://sourcegraph.com/github.com/npm/.github/)
  - [jenkinsci](https://sourcegraph.com/github.com/jenkinsci/.github/)
  - [asyncapi](https://sourcegraph.com/github.com/asyncapi/.github/)
  - [protocol](https://sourcegraph.com/github.com/protocol/.github/)
  - [pagonxt](https://sourcegraph.com/github.com/pagonxt/.github/)
- Others:
  - `ISSUE_TEMPLATE`
    - Good `ISSUE_TEMPLATE` ussing `.yml`
      - [fastify](https://sourcegraph.com/github.com/fastify/.github/-/tree/.github/ISSUE_TEMPLATE)
      - [EddieHubCommunity](https://sourcegraph.com/github.com/EddieHubCommunity/.github/-/tree/.github/ISSUE_TEMPLATE)
    - `ISSUE_TEMPLATE/config.yml`
      - [creativecommons/.github](https://sourcegraph.com/github.com/creativecommons/.github/-/blob/.github/ISSUE_TEMPLATE/config.yml)
  - labels:
    - officials
      - [managing-labels](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels)
    - probot
      - [octoherd](https://sourcegraph.com/github.com/octoherd/.github/-/blob/.github/settings.yml?L32)
    - More info below inside Label section
  - [`CODEOWNERS`](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners)
    - [asdf-community](https://sourcegraph.com/github.com/asdf-community/.github/-/blob/.github/CODEOWNERS)
  - .editorconfig
    - [asdf-community](https://sourcegraph.com/github.com/asdf-community/.github/-/blob/.editorconfig)
  - FUNDING.yml
    - [BlackIQ](https://sourcegraph.com/github.com/BlackIQ/.github/-/blob/FUNDING.yml)
  - Contributor License Agreement
    - [twitter](https://sourcegraph.com/github.com/twitter/.github/-/blob/cla/cla.md)
  - `workflow-templates` folder
    - [MetaMask](https://sourcegraph.com/github.com/MetaMask/.github/-/blob/workflow-templates/build-lint-test.yml)
    - [kowainik](https://sourcegraph.com/github.com/kowainik/.github/-/tree/workflow-templates)
- `lockdown.yml`
  - [lockdown.yml](https://sourcegraph.com/github.com/fuchsia-mirror/.github/-/blob/.github/lockdown.yml)

### Questions

### Proposal

## Labels

ADD: committed,blocked

### Info

- [Managing default labels for repositories in your organization](https://docs.github.com/en/organizations/managing-organization-settings/managing-default-labels-for-repositories-in-your-organization)
  - Clicly in the GUI
- "Some automation" and saved into `.github repo`
  - [dailydotdev](https://sourcegraph.com/github.com/dailydotdev/.github/-/blob/config/github_labels.json)
  - prometheus/prometheus and prometheus/alertmanager
    - For PR organizations, folder and files
      - "labeler.yml" with github.com/actions/labeler
    - Inside each repo
      - "labels.yml" with all the labels with [micnncim/action-label-syncer](https://github.com/micnncim/action-label-syncer)

### Questions

- [Clicly in the GUI](https://docs.github.com/en/organizations/managing-organization-settings/managing-default-labels-for-repositories-in-your-organization)
- As code
  - labels in .github repo ? official support?
    - No
  - labels in .github repo ? Acction to atack the API ? (exists or not?)
    - Yes...
    - .github repo and subfolder with heritance. Using probot app or customs actions

### Proposal

## Reports

- Issues without milestones
- Issues Without projects

### Info

https://sourcegraph.com/search?q=context:global+%22github-issues%22+file:.github-issues&patternType=literal
https://sourcegraph.com/github.com/microsoft/vscode-npm-scripts/-/blob/issues.github-issues
https://github.com/microsoft/azuredatastudio/blob/main/.vscode/notebooks/grooming.github-issues

### Questions

### Proposal

## Workflow
- update-changelog
  - https://sourcegraph.com/github.com/laravel/.github/-/blob/.github/workflows/update-changelog.yml


## Other
- profile.yml
  - [Color](https://sourcegraph.com/github.com/vimal-verma/.github/-/blob/profile.yml) ??
- [prevent-public-repos](https://github.com/apps/prevent-public-repos)
- https://github.com/git-chglog/git-chglog



## Check runs

- https://sourcegraph.com/search?q=context:global+and+check_runs+and+in_progress+file:%5C.github/workflows&patternType=literal
  - https://github.com/external-secrets/external-secrets/blob/main/.github/workflows/e2e-managed.yml




https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels
https://opensource.guide/building-community/
https://opensource.guide/leadership-and-governance/



https://sourcegraph.com/github.com/angular/.github/-/blob/.github/in-solidarity.yml
https://sourcegraph.com/github.com/doctrine/.github/-/tree/workflow-templates
https://sourcegraph.com/github.com/googleapis/.github/-/tree/allstar
https://sourcegraph.com/github.com/obsproject/.github/-/blob/.github/ISSUE_TEMPLATE/config.yml
https://sourcegraph.com/github.com/flutter/.github/-/tree/profile
https://sourcegraph.com/github.com/doomemacs/.github
https://sourcegraph.com/github.com/MacrowebCloud/.github/-/tree/assets
https://sourcegraph.com/github.com/elementary/.github/-/tree/.github/ISSUE_TEMPLATE
https://sourcegraph.com/github.com/aosp-mirror/.github/-/blob/mistaken-pull-closer.yml
https://sourcegraph.com/github.com/OpenMined/.github/-/blob/language_standards/c++/.clang-format?L31
https://sourcegraph.com/github.com/jessesquires/.github/-/tree/.github/ISSUE_TEMPLATE
https://sourcegraph.com/github.com/spring-projects/.github
https://sourcegraph.com/github.com/hashicorp/.github
https://sourcegraph.com/github.com/pallets/.github/-/tree/workflow-templates
https://sourcegraph.com/github.com/stellar/.github/-/tree/profile
https://sourcegraph.com/github.com/benbalter/.github/-/blob/README.md
https://sourcegraph.com/github.com/cloudflare/.github
https://sourcegraph.com/github.com/kowainik/.github/-/blob/workflow-templates/ci.yml
https://sourcegraph.com/github.com/github/.github/-/blob/profile/README.md
https://sourcegraph.com/github.com/vanillawc/.github/-/tree/assets
https://sourcegraph.com/github.com/rnc-archive/.github/-/blob/.github/PULL_REQUEST_TEMPLATE.md
https://sourcegraph.com/github.com/Debian/.github/-/blob/.github/ISSUE_TEMPLATE/join.yml
https://sourcegraph.com/github.com/MicrosoftDocs/.github/-/blob/SECURITY.MD
https://sourcegraph.com/github.com/microsoft/.github/-/blob/SECURITY.md
https://sourcegraph.com/github.com/atom/.github/-/blob/CODE_OF_CONDUCT.md
https://sourcegraph.com/github.com/coopTilleuls/.github/-/blob/profile/README.md


https://sourcegraph.com/search?q=context:global+repo:.*/.github&patternType=literal&case=yes
https://sourcegraph.com/search?q=context:global+repo:.*/.github+file:%5E%5C.github&patternType=literal&case=yes
