#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

check_missing_pem() {
  file="$1"
  
  if [[ ! -f "$file" ]]; then
    echo "Missing .pem file: $file"
    return 1
  fi
  
  return 0
}

scan_repository() {
  while IFS= read -r -d '' file; do
    if [[ "$file" == *.pem ]]; then
      check_missing_pem "$file"
    fi
  done < <(find "$REPO_PATH" -type f -print0)
}

scan_repository

exit_status=$?
exit "$exit_status"
