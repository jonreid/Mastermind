#!/usr/bin/env bash
set -euo pipefail

TMP_OUTPUT=$(mktemp)
trap 'rm -f "$TMP_OUTPUT"' EXIT

if cd MastermindCore && swift test > "$TMP_OUTPUT" 2>&1; then
  read -r XCTEST_COUNT SWIFT_TEST_COUNT <<< $(
    awk '
      /Executed [0-9]+ tests?/ && !xctest_counted {
        xctest=$2
        xctest_counted=1
      }
      /Test run with [0-9]+ tests/ {
        split($0, words, " ")
        for (i = 1; i <= length(words); i++) {
          if (words[i] == "with" && words[i+1] ~ /^[0-9]+$/) {
            swift = words[i+1]
            break
          }
        }
      }
      END {
        print xctest+0, swift+0
      }
    ' "$TMP_OUTPUT"
  )
  TOTAL_TESTS=$((XCTEST_COUNT + SWIFT_TEST_COUNT))
  echo "✅ All tests passed: $TOTAL_TESTS tests."
else
  cat "$TMP_OUTPUT"
  if grep -q "Test run.*failed\|Test Suite.*failed\|recorded an issue" "$TMP_OUTPUT"; then
    echo "❌ Tests failed."
  else
    echo "❌ Build failed."
  fi
  exit 1
fi
