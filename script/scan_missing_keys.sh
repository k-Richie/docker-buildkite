steps:
  - label: "Scan Repository for Access Key and Secret Key"
    command: |
      #!/bin/bash

      REPO_PATH="/path/to/your/repo"

      check_file() {
        local file="$1"

        # Check if file is empty
        if [[ ! -s "$file" ]]; then
          echo "File is empty: $file"
          return 1
        fi

        # Check for missing access key and secret key
        if ! grep -qE "access_key\s*=\s*" "$file" || ! grep -qE "secret_key\s*=\s*" "$file"; then
          echo "Missing access key or secret key: $file"
          return 1
        fi

        # Check for incorrect indentation
        if grep -qE "^\s*access_key\s*=\s*" "$file" || grep -qE "^\s*secret_key\s*=\s*" "$file"; then
          echo "Incorrect indentation: $file"
          return 1
        fi

        return 0
      }

      scan_repository() {
        local has_issues=false

        while IFS= read -r -d '' file; do
          if ! check_file "$file"; then
            has_issues=true
          fi
        done < <(find "$REPO_PATH" -type f -name "*.txt" -print0)

        if [[ "$has_issues" = true ]]; then
          return 1
        else
          return 0
        fi
      }

      scan_repository

      exit_status=$?
      exit "$exit_status"
    agents:
      queue: "your-buildkite-queue"

