# GitHub

## Get all labels in GitHub organization

Github CLI alias [`repos-name-all` in `gh/config.yml`](https://github.com/svg153/configLinux/blob/2272f292cc8c49ddf484d8955a8bbc7ae7a08d7c/.config/gh/config.yml#L22)

Generate a github token

Go to [label-exporter clone](https://github.com/svg153/label-exporter/)

Change: "UUUUU", "XXXXX"

```bash
GITHUB_TOKEN="XXXXX"
USER="UUUUU"
for r in $(gh repos-name-all "${USER}"); do make docker-repo token="${GITHUB_TOKEN}" org_label="${USER}" repo_label="${r}" >> labels.yaml; done
yq 'unique_by(.name) | sort_by(.name)' labels.yaml > labels_uniqs.yaml
```

## Run and watch workflow

```bash
WF="build.yml"
gh workflow run ${WF} --ref $(git branch-name); sleep 10s; gh run watch $(gh run list --branch=$(git branch --show) --workflow ${WF} --limit 1 --json="conclusion,createdAt,databaseId,event,headBranch,headSha,name,status,updatedAt,url,workflowDatabaseId" --jq='.[].databaseId')
```

## github configuration as code

### Example repositories

- [cucumber organization](https://github.com/cucumber/):
  - [.github](https://github.com/cucumber/.github), use [probot/settings].
  - [github-settings](https://github.com/cucumber/github-settings), with Pulumi code
- [govuk org configuration](https://github.com/alphagov/govuk-saas-config)
- [sigstore/community](https://github.com/sigstore/community)

#### Tool and documentation

All use the [GitHub API](https://docs.github.com/en/rest):

- [octokit.js](https://github.com/octokit/octokit.js) is used by [github/safe-settings] and [probot/settings]
- [go-github](https://github.com/google/go-github)
  - [Terraform GitHub provider](https://registry.terraform.io/providers/integrations/github/latest/docs)
    - modules
      - <https://github.com/concourse/governance/tree/master>
      - <https://github.com/mineiros-io/github-as-code-example>
    - docs
      - <https://www.hashicorp.com/blog/managing-github-with-terraform>
      - <https://developer.hashicorp.com/terraform/tutorials/it-saas/github-user-teams>
      - <https://blog.terramate.io/how-to-manage-your-github-organization-with-terraform-1b584b2ea177>
      - [GitHub organization with terraform](https://www.mineiros.io/blog/how-to-manage-your-github-organization-with-terraform)
      - <https://spacelift.io/blog/terraform-github>
  - [Crossplane GitHub provider][crossplane-contrib/provider-github]
    - [crossplane/org](https://github.com/crossplane/org/), using Crossplane to manage [organization members](https://github.com/crossplane/org/blob/main/config/members-crossplane.yaml)
      - [stone-payments/crossplane-provider-github](https://github.com/stone-payments/crossplane-provider-github/) Crossplane provider to manage GitHub repositories.
    - [PoC of vshn organization](https://github.com/vshn/crossplane-git-poc) to use Crossplane for member management in GitHub and GitLab
    - Using jet:
      - [HotThoughts/provider-jet-github](https://github.com/HotThoughts/provider-jet-github)
      - [PoC of LucaLanziani](https://github.com/LucaLanziani/crossplane-jet-github) a fork of [crossplane-contrib/provider-github]
    - Using upjet (new):
      - [coopnorge/provider-github](https://github.com/coopnorge/provider-github)
  - [kubernetes](https://github.com/kubernetes/test-infra)
    - [peribolos](https://github.com/kubernetes/test-infra/tree/master/prow/cmd/peribolos): allows the org settings, teams and memberships to be declared in a yaml file. GitHub is then updated to match the declared configuration.
- Commercial tools:
  - [mineiros-io/github-as-code-example](https://github.com/mineiros-io/github-as-code-example)
    - <https://mineiros.io/github-as-code>

- GitHub workflow to apply the github config terraform code
  - <https://github.com/concourse/governance/blob/master/.github/workflows/terraform.yml>

[github/safe-settings]: https://github.com/github/safe-settings
[probot/settings]: https://github.com/probot/settings
[crossplane-contrib/provider-github]: https://github.com/crossplane-contrib/provider-github
