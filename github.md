# github

## github configuration as code

### Example repositories

- [cucumber organization](https://github.com/cucumber/):
  - [.github](https://github.com/cucumber/.github), use [probot/settings].
  - [github-settings](https://github.com/cucumber/github-settings), with Pulumi code
- [govuk org configuration](https://github.com/alphagov/govuk-saas-config)

#### Tool and documentation

All use the [GitHub API](https://docs.github.com/en/rest):

- [octokit.js](https://github.com/octokit/octokit.js) is used by [github/safe-settings] and [probot/settings]
- [go-github](https://github.com/google/go-github)
  - [Terraform GitHub provider](https://registry.terraform.io/providers/integrations/github/latest/docs)
    - [GitHub organization with terraform](https://www.mineiros.io/blog/how-to-manage-your-github-organization-with-terraform)
  - [Crossplane GitHub provider](https://github.com/crossplane-contrib/provider-github)
    - [crossplane/org](https://github.com/crossplane/org/), using crossplane to manage [organization members](https://github.com/crossplane/org/blob/main/config/members-crossplane.yaml)
    - [PoC of vshn organization](https://github.com/vshn/crossplane-git-poc) to use crossplane for member management in github and gitlab
  
[github/safe-settings]: https://github.com/github/safe-settings
[probot/settings]: https://github.com/probot/settings
