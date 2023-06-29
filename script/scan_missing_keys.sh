#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

echo "Searching for files containing Access_key..."

find "$REPO_PATH" -type f -exec grep -H "Access_key" {} + | while IFS=: read -r file line; do
  if grep -qE '^\s*Access_key\s*=' "$file"; then
    echo "File contains Access_key with correct indentation: $file"
  else
    echo "File contains Access_key with incorrect indentation: $file"
  fi
done




