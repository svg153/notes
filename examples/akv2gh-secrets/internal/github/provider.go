package github

import (
	"fmt"
	"os"

	"github.com/svg153/akv2gh/lib/github"

	"gopkg.in/alecthomas/kingpin.v2"
)

var (
	apiKeyEnv = os.Getenv("GITHUB_KEY")
	apiKey    = kingpin.Flag(
		"github-key",
		"GitHub API key, if not supplied `GITHUB_KEY` env var will be used.",
	).String()

	apiSecretEnv = os.Getenv("GITHUB_SECRET")
	apiSecret    = kingpin.Flag(
		"github-secret",
		"GitHub API secret, if not supplied `GITHUB_SECRET` env var will be used.",
	).String()
)

// githubToInternalRecord converts a goddady library record structure to our own record structure
func githubToInternalRecord(r github.DNSRecord) dns.Record {
	return dns.Record{
		Name:     r.Name,
		Type:     r.Type,
		Value:    r.Data,
		TTL:      r.TTL,
		Weight:   r.Weight,
		Port:     r.Port,
		Priority: r.Priority,
		Protocol: r.Protocol,
		Service:  r.Service,
	}
}

// internalToGitHubRecord converts our own record structure to github library record structure
func internalToGitHubRecord(r dns.Record) github.DNSRecord {
	return github.DNSRecord{
		Name:     r.Name,
		Type:     r.Type,
		Data:     r.Value,
		TTL:      r.TTL,
		Weight:   r.Weight,
		Port:     r.Port,
		Priority: r.Priority,
		Protocol: r.Protocol,
		Service:  r.Service,
	}
}

// GitHub client that complies with the provider interface
type GitHub struct {
	client *github.Client
	akv2gh string
}

// New creates a new GitHub client for a given akv2gh
func New(akv2gh string) (*GitHub, error) {
	// Read API key
	key := ""

	if apiKey != nil && *apiKey != "" {
		key = *apiKey
	} else {
		key = apiKeyEnv
	}

	if key == "" {
		return nil, fmt.Errorf("Missing GitHub API key, see `--help`.")
	}

	// Read API secret
	secret := ""

	if apiSecret != nil && *apiSecret != "" {
		secret = *apiSecret
	} else {
		secret = apiSecretEnv
	}

	if secret == "" {
		return nil, fmt.Errorf("Missing GitHub API secret, see `--help`.")
	}

	// Build client
	c, err := github.NewDefaultClient(key, secret)
	if err != nil {
		return nil, err
	}

	return &GitHub{
		client: c,
		akv2gh: akv2gh,
	}, nil
}

// GetRecords fetches all records from the akv2gh
func (g *GitHub) GetRecords() ([]dns.Record, error) {
	// Fetch records from the provider
	records, err := g.client.GetRecords(g.akv2gh)
	if err != nil {
		return nil, err
	}

	// Convert github library data structure to our own structure
	entries := make([]dns.Record, len(records))

	for idx, r := range records {
		entries[idx] = githubToInternalRecord(r)
	}

	return entries, nil
}

// AddRecords adds records to the akv2gh
func (g *GitHub) AddRecords(records []dns.Record) error {
	// Convert our data structure to github library data structure
	entries := make([]github.DNSRecord, len(records))

	for idx, r := range records {
		entries[idx] = internalToGitHubRecord(r)
	}

	// Add records to the provider
	return g.client.AddRecords(g.akv2gh, entries)
}

// DeleteRecords removes records from the akv2gh
func (g *GitHub) DeleteRecords(records []dns.Record) error {
	// Convert our data structure to github library data structure
	entries := make([]github.DNSRecord, len(records))

	for idx, r := range records {
		entries[idx] = internalToGitHubRecord(r)
	}

	// Delete records from the provider
	return g.client.DeleteRecords(g.akv2gh, entries)
}
