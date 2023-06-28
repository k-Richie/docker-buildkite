#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

BAD_PERMISSIONS=("777")

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
  local has_bad_permissions=false

  while IFS= read -r -d '' file; do
    if ! check_file_permission "$file"; then
      has_bad_permissions=true
    fi
  done < <(find "$REPO_PATH" -type f -print0)

  if [[ "$has_bad_permissions" = true ]]; then
    return 1
  else
    return 0
  fi
}

scan_repository

exit_status=$?
if [[ $exit_status -eq 0 ]]; then
  echo "No files with bad permissions found."
else
  echo "Scan completed with files having bad permissions."
fi

