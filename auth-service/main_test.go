package main

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthHandler(t *testing.T) {
	app := &App{}
	req := httptest.NewRequest(http.MethodGet, "/health", nil)
	res := httptest.NewRecorder()

	app.healthHandler(res, req)

	if res.Code != http.StatusOK {
		t.Fatalf("expected status 200, got %d", res.Code)
	}

	var body map[string]string
	if err := json.NewDecoder(res.Body).Decode(&body); err != nil {
		t.Fatalf("invalid json response: %v", err)
	}

	if body["status"] != "ok" {
		t.Fatalf("expected status ok, got %q", body["status"])
	}
}

func TestGenerateAPIKey(t *testing.T) {
	key, err := generateAPIKey()
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	if len(key) <= len("tm_key_") {
		t.Fatalf("generated key is too short")
	}

	if key[:7] != "tm_key_" {
		t.Fatalf("expected key prefix tm_key_, got %q", key[:7])
	}
}

func TestHashAPIKey(t *testing.T) {
	hash := hashAPIKey("example-key")

	if len(hash) != 64 {
		t.Fatalf("expected SHA-256 hash with 64 chars, got %d", len(hash))
	}

	if hash != hashAPIKey("example-key") {
		t.Fatalf("hash must be deterministic")
	}
}
