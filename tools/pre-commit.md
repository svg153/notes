# pre-commit

## GitHub Action

### Analysis

#### pre-commit GitHub Action

- The [pre-commit action](https://github.com/pre-commit/action) is working, but _is in maintenance-only mode and will not be accepting new features_.
- It will [not include new features like change the git commit message](https://github.com/pre-commit/action/pull/37#issuecomment-832151204) when pre-commit autofix some issues in the workflow (#26). This will be necessary, if we decided to have a commit message standard (add the issue number at the begging of the commit message).

#### Alternatives pre-commit GitHub Action (forks)

- [cloudposse/github-action-pre-commit](https://github.com/cloudposse/github-action-pre-commit). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...cloudposse:master)
  - Custom [commit author](https://github.com/pre-commit/action/compare/master...cloudposse:master#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5R75) ([git_user_name](https://github.com/pre-commit/action/compare/master...cloudposse:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R87) + [git_user_email](https://github.com/pre-commit/action/compare/master...cloudposse:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R89)) and [commit message](https://github.com/pre-commit/action/compare/master...cloudposse:master#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6R23) ([git_commit_message](https://github.com/pre-commit/action/compare/master...cloudposse:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R95)) for autofix commit.
  - [Action branding](https://github.com/pre-commit/action/compare/master...cloudposse:master#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6R3)
- [LilSpazJoekp/pre-commit-action](https://github.com/LilSpazJoekp/pre-commit-action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...LilSpazJoekp:master)
  - GitHub [workflow to publish](https://github.com/pre-commit/action/compare/master...LilSpazJoekp:master#diff-551d1fcf87f78cc3bc18a7b332a4dc5d8773a512062df881c5aba28a6f5c48d7) his pre-commmit action fork.
  - Fix [pip and python problem](https://github.com/pre-commit/action/compare/master...LilSpazJoekp:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R37)
- [cdrx/pre-commit-action](https://github.com/cdrx/pre-commit-action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...cdrx:master)
  - Custom commit author ([committer_name](https://github.com/pre-commit/action/compare/master...cdrx:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R80) + [committer_email](https://github.com/pre-commit/action/compare/master...cdrx:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R82)) and [commit message](https://github.com/pre-commit/action/compare/master...cdrx:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R88) ([commit_prefix + commit_message](https://github.com/pre-commit/action/compare/master...cdrx:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R62)) for autofix commit.
- [aaronmak/action](https://github.com/aaronmak/action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...aaronmak:master)
  - Custon [commitMessage from the inputs action var](https://github.com/pre-commit/action/compare/master...aaronmak:master#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6R11).
- [xmartinez/pre-commit-action](https://github.com/xmartinez/pre-commit-action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...xmartinez:master)
  - pre-commit only caches the `.pre-commit-config.yaml` located in the root of the repo.
    - pass [`config` input var](https://github.com/pre-commit/action/compare/master...xmartinez:master#diff-1243c5424efaaa19bd8e813c5e6f6da46316e63761421b3e5f5c8ced9a36e6b6R4) to the action to specify a different config file.
    - Changes to cached the file passed by args... [Caching for custom config](https://github.com/pre-commit/action/compare/master...xmartinez:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R56).
- [puqeko/pre-commit-action](https://github.com/puqeko/pre-commit-action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...puqeko:master)
  - pre-commit only caches the `.pre-commit-config.yaml` located in the root of the repo.
    - Changes to cached the file passed by args... [Caching for custom config](https://github.com/pre-commit/action/compare/master...puqeko:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R53).
- [madhao/action](https://github.com/madhao/action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...madhao:master)
  - change def behavior to run in changes files. [Remove `--all-files`](https://github.com/pre-commit/action/compare/master...madhao:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R6).
- [jirikuncar/action](https://github.com/jirikuncar/action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...jirikuncar:master)
  - Only run in all files if source and origin [are not passed by input vars](https://github.com/pre-commit/action/compare/master...jirikuncar:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R31).
- [travisgroth/action](https://github.com/travisgroth/action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...travisgroth:master)
  - He created a [PR in pre-commit official repo](https://github.com/pre-commit/action/pull/22).
  - Run in changed files or not depend on [`cache` input variable](https://github.com/pre-commit/action/compare/master...travisgroth:master#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5R90).
- [pechersky/action](https://github.com/pechersky/action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...pechersky:master)
  - [Implement cache for pre-commit](https://github.com/pre-commit/action/compare/master...pechersky:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R59)
    - [nektos/act](https://github.com/nektos/act) doesn't support the cache action, so [branch around it, using the envvar that it uses](https://github.com/pre-commit/action/compare/master...pechersky:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R51).
- [cognitedata/pre-commit-action](https://github.com/cognitedata/pre-commit-action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...cognitedata:master)
  - fix version of [pre-commit==2.10.1](https://github.com/pre-commit/action/compare/master...cognitedata:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R37) and [presentation==0.0.32](https://github.com/pre-commit/action/compare/master...cognitedata:master#diff-76ed074a9305c04054cdebb9e9aad2d818052b07091de1f20cad0bbac34ffb52R7) and
- [simonwiles/precommit-action](https://github.com/simonwiles/precommit-action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...simonwiles:master)
  - [fix install on GA Windows runners](https://github.com/pre-commit/action/compare/master...simonwiles:master#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5R1) use `python -m pip` instead of `pip` only.
- [vatanaksoytezer/action](https://github.com/vatanaksoytezer/action). The [diffs with pre-commit repo](https://github.com/pre-commit/action/compare/master...vatanaksoytezer:master)
  - [Ignore setup.cfg file](https://github.com/pre-commit/action/compare/master...vatanaksoytezer:master#diff-e727e4bdf3657fd1d798edcd6b099d6e092f8573cba266154583a746bba0f346R37)
- Fork by us in our organization

#### pre-commit GitHub App

- The official documentation recommend switch to the app.
- The app has the feature to change the git commit message in the autofix.
- This application would be paid for our organization, "$20 user/month".

### Proposal solution

In both cases would be interesting:

- Investigate this issue <https://github.com/pre-commit/action/issues/7>
- Investigate cache, if the action not already implement it

#### nothing until standard

Do nothing until we decide if we put a standard to the commits

#### [cloudposse/github-action-pre-commit](https://github.com/cloudposse/github-action-pre-commit)

It would be a good alternative:

- :+1: It is forked by an organization instead of a single person.
- :+1: Has the feature of changing the git author and commit message for the pre-commit autofix.
- :-1: Not fixed the _python - pip_ problem. But we can create a PR from other fork.
- :-1: Not fixed the cache with custom config problem. But we can create a PR from other fork.
