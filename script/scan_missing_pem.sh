#!/bin/bash
REPO_PATH="/home/rachana/buildkite/docker-buildkite"
check_pem_files() {
  while IFS= read -r -d '' file; do
    if [[ "$file" == *.pem ]]; then
      echo "Found .pem file: $file"
      return 0
    fi
  done < <(find "$REPO_PATH" -type f -print0)
  echo "No .pem files found in the repository."
  return 1
}
check_pem_files
echo "Exit status: $?"






