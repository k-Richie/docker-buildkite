#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

check_missing_keys() {
  file="$1"

  if ! grep -qE "access_key|secret_key" "$file"; then
    echo "Missing access key or secret key in file: $file"
    return 1
  fi

  if grep -qE "^\s*(access_key|secret_key)" "$file"; then
    echo "Incorrect indentation in file: $file"
    return 1
  fi

  return 0
}

scan_repository() {
  while IFS= read -r -d '' file; do
    check_missing_keys "$file"
  done < <(find "$REPO_PATH" -type f -print0)
}

scan_repository
exit_status=$?




