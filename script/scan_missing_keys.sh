steps:
  - label: "Scan File for Missing Access Key and Secret Key"
    command: |
      #!/bin/bash

      FILE_PATH="/path/to/your/file"

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

      check_file "$FILE_PATH"
      
      exit_status=$?
      exit "$exit_status"
    agents:
      queue: "your-buildkite-queue"
