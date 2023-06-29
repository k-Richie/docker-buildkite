#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"
BAD_PERMISSIONS=("777" "666")

scan_repository() {
  local has_bad_permissions=false

  for permission in "${BAD_PERMISSIONS[@]}"; do
    find "$REPO_PATH" -type f -perm "$permission" -execdir echo "Bad permission found: {}" \; \
      && has_bad_permissions=true
  done

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

exit "$exit_status"



