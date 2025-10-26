#!/usr/bin/env bash
set -euo pipefail

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=18.5,name=iPhone 16'

if grep -R -n --include='*Tests.swift' -E '^\s*// (Arrange|Act|Assert|Given|When|Then)\b' . ; then
  echo "Error: Forbidden test comments detected. Remove these comments from tests."
  exit 1
fi

TMP_OUTPUT=$(mktemp)
if xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO' > "$TMP_OUTPUT" 2>&1; then
  XCTEST_COUNT=$(grep -A 1 "Test Suite 'All tests' passed" "$TMP_OUTPUT" | grep -Eo 'Executed [0-9]+' | grep -Eo '[0-9]+' || echo "0")
  SWIFT_TEST_COUNT=$(grep "✔ Test run with" "$TMP_OUTPUT" | grep -Eo 'with [0-9]+ tests' | grep -Eo '[0-9]+' || echo "0")
  TOTAL_TESTS=$((XCTEST_COUNT + SWIFT_TEST_COUNT))
  echo "✅ All tests passed: $TOTAL_TESTS tests."
  EXIT_CODE=0
else
  cat "$TMP_OUTPUT"
  echo "❌ Build failed."
  EXIT_CODE=1
fi
rm "$TMP_OUTPUT"
exit $EXIT_CODE
