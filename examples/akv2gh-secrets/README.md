# akv2gh

Simple tool for managing domains as code (YAML files).

## Build

Using docker/podman:

```sh
docker build . -t akv2gh:latest
```

Native build:

```sh
go build -o akv2gh ./cmd/akv2gh
```

## Usage

The tool comes with built-in help, just run it with the `--help` or
`--help-long` flag.

```sh
docker run -it --rm akv2gh --help-long
```

It has 3 main commands:

- `apply` which applies the local state of a akv2gh to the remote
  provider. Before applying it pretty-prints the changes and asks for
  confirmation (except if `--auto-approve` is specified).
- `diff` which computes the differences between the local and remote states and
  prints it in diff unified format (this can be syntax-colored or parsed with
  3rd party tools: markdown, bat, git-delta, diff-so-fancy, ...).
- `dump` which dumps the remote state of a akv2gh in a YAML file. Intended for
  creating the local state for existing domains.

Each provider requires the credentials to be supplied by command line flags or
by environment variables. See help for more information.

Example:

```sh
docker run -it --rm \
    -e GITHUB_KEY=$GITHUB_KEY \
    -e GITHUB_SECRET=$GITHUB_SECRET \
    -v $(pwd)/akv2gh.yaml:/tmp/akv2gh.yaml \
    akv2gh -f /tmp/akv2gh.yaml apply
```
