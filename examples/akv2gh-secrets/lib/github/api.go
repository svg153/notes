package github

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"path"
	"time"
)

const (
	ProdURL = "https://api.github.com"
	TestURL = "https://api.ote-github.com"
)

type Client struct {
	httpClient *http.Client
	baseURL    *url.URL
	apiKey     string
	apiSecret  string
}

// NewClient creates a new GitHub client
func NewClient(apiKey string, apiSecret string, apiURL string, timeout time.Duration) (*Client, error) {
	baseURL, err := url.Parse(apiURL)
	if err != nil {
		return nil, err
	}

	return &Client{
		httpClient: &http.Client{Timeout: timeout},
		baseURL:    baseURL,
		apiKey:     apiKey,
		apiSecret:  apiSecret,
	}, nil
}

// NewDefaultClient creates a new GitHub prod client with the default 5 seconds timeout
func NewDefaultClient(apiKey string, apiSecret string) (*Client, error) {
	return NewClient(apiKey, apiSecret, ProdURL, 5*time.Second)
}

func (c *Client) request(method string, uri string, body io.Reader) (*http.Response, error) {
	resource, err := c.baseURL.Parse(path.Join(c.baseURL.Path, uri))
	if err != nil {
		return nil, err
	}

	req, err := http.NewRequest(method, resource.String(), body)
	if err != nil {
		return nil, err
	}

	req.Header.Set("Accept", "application/json")
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", fmt.Sprintf("sso-key %s:%s", c.apiKey, c.apiSecret))

	return c.httpClient.Do(req)
}

// GetRecords returns the current records of the akv2gh
func (c *Client) GetRecords(akv2gh string) ([]DNSRecord, error) {
	resource := path.Clean(fmt.Sprintf("/v1/domains/%s/records", akv2gh))
	resp, err := c.request(http.MethodGet, resource, nil)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	bodyBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed reading response (status: %d)", resp.StatusCode)
	}

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("failed fetching records (status: %d): %s", resp.StatusCode, string(bodyBytes))
	}

	records := []DNSRecord{}
	if json.Unmarshal(bodyBytes, &records) != nil {
		return nil, fmt.Errorf("failed decoding records (status: %d): %s", resp.StatusCode, string(bodyBytes))
	}

	return records, nil
}

// AddRecords adds a new set of records
func (c *Client) AddRecords(akv2gh string, records []DNSRecord) error {
	recordsBody, err := json.Marshal(records)
	if err != nil {
		return err
	}

	resource := path.Clean(fmt.Sprintf("/v1/domains/%s/records", akv2gh))
	resp, err := c.request(http.MethodPatch, resource, bytes.NewReader(recordsBody))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	bodyBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("failed reading response (status: %d)", resp.StatusCode)
	}

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("failed updating records (status: %d): %s", resp.StatusCode, string(bodyBytes))
	}

	return nil
}

// DeleteRecords deletes a set of records.
// GitHub API is pretty bad and doesn't give you a "delete record" call, you have to operate
// over the full DNS Zone, over Record types or over Record and Name types. The logic option
// here is to grab all records by the same type and name and delete the matching one. But this
// doesn't work for DNS Records with '@' name, so we have to do it over the full DNS Zone.
func (c *Client) DeleteRecords(akv2gh string, records []DNSRecord) error {
	zoneRecords, err := c.GetRecords(akv2gh)
	if err != nil {
		return err
	}

	for _, deleteRecord := range records {
		for idx, zoneRecord := range zoneRecords {
			if deleteRecord.IsEqual(zoneRecord) {
				zoneRecords[idx] = zoneRecords[len(zoneRecords)-1]
				zoneRecords = zoneRecords[:len(zoneRecords)-1]
				break
			}
		}
	}

	zoneRecordsBody, err := json.Marshal(zoneRecords)
	if err != nil {
		return err
	}

	resource := path.Clean(fmt.Sprintf("/v1/domains/%s/records", akv2gh))
	resp, err := c.request(http.MethodPut, resource, bytes.NewReader(zoneRecordsBody))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	bodyBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("failed reading response (status: %d)", resp.StatusCode)
	}

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("failed updating records (status: %d): %s", resp.StatusCode, string(bodyBytes))
	}

	return nil
}
