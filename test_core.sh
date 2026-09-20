#!/usr/bin/env bash
set -euo pipefail

cd MastermindCore

TMP_OUTPUT=$(mktemp)
trap 'rm -f "$TMP_OUTPUT"' EXIT

compile_strings_bundle() {
  local bundle
  bundle="$(swift build --show-bin-path)/MastermindCore_MastermindCore.bundle"
  xcrun xcstringstool compile Sources/MastermindCore/Resources/Localizable.xcstrings --output-directory "$bundle"
}

run_tests() {
  if [[ "${1:-}" == "--strings" ]]; then
    swift build --build-tests
    compile_strings_bundle
    swift test --skip-build
  else
    swift test
  fi
}

drop_build_output() {
  if grep -q '^Build complete!' "$TMP_OUTPUT"; then
    awk 'NR==FNR { if (/^Build complete!/) last = FNR; next } FNR > last' "$TMP_OUTPUT" "$TMP_OUTPUT"
  else
    cat "$TMP_OUTPUT"
  fi
}

count_tests() {
  awk '
    /Executed [0-9]+ tests?/ && !xctest_counted {
      xctest=$2
      xctest_counted=1
    }
    /Test run with [0-9]+ tests?/ {
      split($0, words, " ")
      for (i = 1; i <= length(words); i++) {
        if (words[i] == "with" && words[i+1] ~ /^[0-9]+$/) {
          swift = words[i+1]
          break
        }
      }
    }
    END {
      print xctest+swift+0
    }
  ' "$TMP_OUTPUT"
}

report_passed_tests() {
  echo "✅ All core tests passed: $(count_tests) tests."
}

print_relevant_output() {
  local pattern
  local -a noise_patterns grep_args
  noise_patterns=(
    'Suite [A-Z][A-Za-z0-9_]* started\.$'
    'Test ".*" started\.$'
    'Test case passing [0-9]+ arguments? .* started\.$'
    'Test .* passed after [0-9.]+ seconds\.$'
    'Suite [A-Z][A-Za-z0-9_]* passed after [0-9.]+ seconds\.$'
    "^Test Suite '[A-Z][A-Za-z0-9_. ]*' started at .*\\.\$"
    '^Test Case .* started\.$'
    '^Test Case .* passed \([0-9.]+ seconds\)\.$'
    '^[[:space:]]*Executed [0-9]+ tests?, with 0 failures \(0 unexpected\) in .*$'
    "^Test Suite '[A-Z][A-Za-z0-9_. ]*' passed at .*\\.\$"
  )
  grep_args=()
  for pattern in "${noise_patterns[@]}"; do
    grep_args+=(-e "$pattern")
  done
  drop_build_output | grep -Ev "${grep_args[@]}" || true
}

failure_verdict() {
  if grep -q "Test run.*failed\|Test Suite.*failed\|recorded an issue" "$TMP_OUTPUT"; then
    echo "❌ Core tests failed."
  else
    echo "❌ Core build failed."
  fi
}

report_failure() {
  print_relevant_output
  failure_verdict
}

if run_tests "${1:-}" > "$TMP_OUTPUT" 2>&1; then
  report_passed_tests
else
  report_failure
  exit 1
fi
