package github

import (
	"reflect"
)

// DNSRecord represents a DNS record with all the fields it can have
type DNSRecord struct {
	Name string `json:"name"`
	TTL  int32  `json:"ttl"`
	Type string `json:"type"`
	Data string `json:"data"`

	// MX and SRV only
	Priority *int32 `json:"priority,omitempty"`

	// SRV only
	Service  *string `json:"service,omitempty"`
	Protocol *string `json:"protocol,omitempty"`
	Weight   *int32  `json:"weight,omitempty"`
	Port     *int32  `json:"port,omitempty"`
}

// IsEqual returns if two DNSRecords are equal
func (dr DNSRecord) IsEqual(other DNSRecord) bool {
	return reflect.DeepEqual(dr, other)
}
