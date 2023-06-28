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
  local has_missing_pem=false
  
  while IFS= read -r -d '' file; do
    if [[ "$file" == *.pem ]]; then
      if ! check_missing_pem "$file"; then
        has_missing_pem=true
      fi
    fi
  done < <(find "$REPO_PATH" -type f -print0)
  
  if [[ "$has_missing_pem" = true ]]; then
    return 1
  else
    return 0
  fi
}

scan_repository

exit_status=$?
if [[ $exit_status -eq 0 ]]; then
  echo "No missing .pem files found."
else
  echo "Scan completed with missing .pem files."
fi

exit "$exit_status"


