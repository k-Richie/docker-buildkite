check_file() {
  local file="$1"
  local has_issue=false

  # Check if file is empty
  if [[ ! -s "$file" ]]; then
    echo "File is empty: $file"
    has_issue=true
  fi

  # Check for missing access key and secret key
  if ! grep -qE "access_key\s*=\s*" "$file" || ! grep -qE "secret_key\s*=\s*" "$file"; then
    echo "Missing access key or secret key: $file"
    has_issue=true
  fi

  # Check for incorrect indentation
  if grep -qE "^\s*access_key\s*=\s*" "$file" || grep -qE "^\s*secret_key\s*=\s*" "$file"; then
    echo "Incorrect indentation: $file"
    has_issue=true
  fi

  if [[ "$has_issue" = true ]]; then
    return 1
  else
    return 0
  fi
}


