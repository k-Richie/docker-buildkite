#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

BAD_PERMISSIONS=("777" "666")

check_file_permission() {
  file="$1"
  permission="$(stat -c "%a" "$file")"
  
  for bad_perm in "${BAD_PERMISSIONS[@]}"; do
    if [[ "$permission" == "$bad_perm" ]]; then
      echo "Bad permission found: $file"
      return 1
    fi
  done
  
  return 0
}

scan_repository() {
  while IFS= read -r -d '' file; do
    check_file_permission "$file"
  done < <(find "$REPO_PATH" -type f -print0)
}

scan_repository

exit_status=$?
exit "$exit_status"
