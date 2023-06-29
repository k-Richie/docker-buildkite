#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

echo "Searching for files containing Access_key..."

for file in "$REPO_PATH"/*; do
  if [[ -f "$file" ]]; then
    if grep -q "Access_key" "$file"; then
      if grep -qE '^\s*Access_key\s*=' "$file"; then
        echo "File contains Access_key with incorrect indentation: $file"
      else
        echo "File contains Access_key with correct indentation: $file"
      fi
    fi
  fi
done




