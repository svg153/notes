package github

import (
	"encoding/json"
	"io"
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestGetRecords(t *testing.T) {
	// Read fixtures
	mockRecordsJSON, err := ioutil.ReadFile("./fixtures/records.json")
	require.NoError(t, err)

	var mockRecords []DNSRecord
	err = json.Unmarshal(mockRecordsJSON, &mockRecords)
	require.NoError(t, err)

	// Prepare mocked API
	mux := http.NewServeMux()
	mux.HandleFunc("/v1/domains/dummy.dummy/records", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		var err error

		switch r.Method {
		case "GET":
			w.WriteHeader(http.StatusOK)
			_, err = w.Write(mockRecordsJSON)

		default:
			w.WriteHeader(http.StatusNotImplemented)
			_, err = w.Write([]byte(`{"code": "test_method", "message": "unexpexted method"}`))
		}

		assert.NoError(t, err)
	})

	mux.HandleFunc("/v1/domains/notowned.akv2gh/records", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		var err error

		switch r.Method {
		case "GET":
			w.WriteHeader(http.StatusNotFound)
			_, err = w.Write([]byte(`{ "code": "UNKNOWN_DOMAIN", "message": "The given akv2gh is not registered, or does not have a zone file" }`))

		default:
			w.WriteHeader(http.StatusNotImplemented)
			_, err = w.Write([]byte(`{"code": "test_method", "message": "unexpexted method"}`))
		}

		assert.NoError(t, err)
	})

	server := httptest.NewServer(mux)
	defer server.Close()

	client, err := NewClient("dummyKey", "dummySecret", server.URL, 5*time.Second)
	require.NoError(t, err)

	// Test response
	t.Run("OwnedDomain", func(st *testing.T) {
		c, err := client.GetRecords("dummy.dummy")

		require.NoError(st, err)
		require.ElementsMatch(st, c, mockRecords)
	})

	t.Run("NotOwnedDomain", func(st *testing.T) {
		_, err := client.GetRecords("notowned.akv2gh")

		require.Error(st, err)
	})
}

func TestAddRecords(t *testing.T) {
	// Read fixtures
	mockAddRecordsJSON, err := ioutil.ReadFile("./fixtures/addrecords.json")
	require.NoError(t, err)

	var mockAddRecords []DNSRecord
	err = json.Unmarshal(mockAddRecordsJSON, &mockAddRecords)
	require.NoError(t, err)

	// Prepare mocked API
	mux := http.NewServeMux()
	mux.HandleFunc("/v1/domains/dummy.dummy/records", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		var err error

		switch r.Method {
		case "PATCH":
			// Read and unmarshal response for easier comparison
			requestBody, _ := io.ReadAll(r.Body)
			var requestRecords []DNSRecord

			err = json.Unmarshal(requestBody, &requestRecords)
			assert.NoError(t, err)

			if assert.ElementsMatch(t, mockAddRecords, requestRecords) {
				w.WriteHeader(http.StatusOK)
			} else {
				w.WriteHeader(http.StatusBadRequest)
				_, err = w.Write([]byte(`{"code": "test_unexpected_deletion", "message": "request doesn't match with the expected"}`))
			}

		default:
			w.WriteHeader(http.StatusNotImplemented)
			_, err = w.Write([]byte(`{"code": "test_method", "message": "unexpexted method"}`))
		}

		assert.NoError(t, err)
	})

	server := httptest.NewServer(mux)
	defer server.Close()

	// Test record addition
	client, err := NewClient("dummyKey", "dummySecret", server.URL, 5*time.Second)
	require.NoError(t, err)

	err = client.AddRecords("dummy.dummy", mockAddRecords)
	require.NoError(t, err)
}

func TestDeleteRecords(t *testing.T) {
	// Read fixtures
	mockRecordsJSON, err := ioutil.ReadFile("./fixtures/records.json")
	require.NoError(t, err)

	mockDeleteRecordsJSON, err := ioutil.ReadFile("./fixtures/deleterecords_recordstodelete.json")
	require.NoError(t, err)

	var mockDeleteRecords []DNSRecord
	err = json.Unmarshal(mockDeleteRecordsJSON, &mockDeleteRecords)
	require.NoError(t, err)

	mockExpectedRecordsJSON, err := ioutil.ReadFile("./fixtures/deleterecords_expectedrecords.json")
	require.NoError(t, err)

	var mockExpectedRecords []DNSRecord
	err = json.Unmarshal(mockExpectedRecordsJSON, &mockExpectedRecords)
	require.NoError(t, err)

	// Prepare mocked API
	mux := http.NewServeMux()
	mux.HandleFunc("/v1/domains/dummy.dummy/records", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")

		var err error

		switch r.Method {
		case "GET":
			w.WriteHeader(http.StatusOK)
			_, err = w.Write(mockRecordsJSON)

		case "PUT":
			// Read and unmarshal response for easier comparison
			requestBody, _ := io.ReadAll(r.Body)
			var requestRecords []DNSRecord

			err = json.Unmarshal(requestBody, &requestRecords)
			assert.NoError(t, err)

			if assert.ElementsMatch(t, mockExpectedRecords, requestRecords) {
				w.WriteHeader(http.StatusOK)
			} else {
				w.WriteHeader(http.StatusBadRequest)
				_, err = w.Write([]byte(`{"code": "test_unexpected_deletion", "message": "request doesn't match with the expected"}`))
			}

		default:
			w.WriteHeader(http.StatusNotImplemented)
			_, err = w.Write([]byte(`{"code": "test_method", "message": "unexpexted method"}`))
		}

		assert.NoError(t, err)
	})

	server := httptest.NewServer(mux)
	defer server.Close()

	// Test record deletion
	client, err := NewClient("dummyKey", "dummySecret", server.URL, 5*time.Second)
	require.NoError(t, err)

	err = client.DeleteRecords("dummy.dummy", mockDeleteRecords)
	require.NoError(t, err)
}
