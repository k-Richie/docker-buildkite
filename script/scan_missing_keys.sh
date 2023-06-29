#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

check_file() {
  local file="$1"

  # Check if file contains "access_key"
  if grep -q "access_key" "$file"; then
    # Check if access key syntax is correct
    if grep -qE 'access_key\s*=\s*".+"' "$file"; then
      echo "File contains access_key with correct syntax: $file"
    else
      echo "File contains access_key with incorrect syntax: $file"
    fi
  fi
}



