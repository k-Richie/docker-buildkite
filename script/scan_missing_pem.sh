#!/bin/bash

REPO_PATH="/home/rachana/buildkite/docker-buildkite"

check_missing_pem() {
  local files=("$@")
  local missing_files=()

  for file in "${files[@]}"; do
    if [[ ! -f "$file" ]]; then
      missing_files+=("$file")
    fi
  done

  echo "${missing_files[@]}"
}

scan_repository() {
  local pem_files=()

  while IFS= read -r -d '' file; do
    if [[ "$file" == *.pem ]]; then
      pem_files+=("$file")
    fi
  done < <(find "$REPO_PATH" -type f -name "*.pem" -print0)

  missing_pem_files=$(check_missing_pem "${pem_files[@]}")

  if [[ -z "$missing_pem_files" ]]; then
    return 0
  else
    echo "Missing .pem files:"
    echo "$missing_pem_files"
    return 1
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





