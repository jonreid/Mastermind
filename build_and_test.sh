#!/usr/bin/env bash
set -euo pipefail

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=26.4.1,name=iPhone 17'

if ! bash test_core.sh; then
  exit 1
fi

if grep -R -n --include='*Tests.swift' -E '^\s*// (Arrange|Act|Assert|Given|When|Then)\b' . ; then
  echo "Error: Forbidden test comments detected. Remove these comments from tests."
  exit 1
fi

TMP_OUTPUT=$(mktemp)
trap 'rm -f "$TMP_OUTPUT"' EXIT

if xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO' > "$TMP_OUTPUT" 2>&1; then
  read -r XCTEST_COUNT SWIFT_TEST_COUNT <<< $(
    awk '
      /Executed [0-9]+/ {
        xctest=$2
      }
      /✔ Test run with/ {
        swift=$5
      }
      END {
        print xctest+0, swift+0
      }
    ' "$TMP_OUTPUT"
  )
  TOTAL_TESTS=$((XCTEST_COUNT + SWIFT_TEST_COUNT))
  echo "✅ All app tests passed: $TOTAL_TESTS tests."
else
  cat "$TMP_OUTPUT" | xcbeautify --renderer github-actions | grep '^::' || true
  echo "❌ App build failed."
  exit 1
fi
