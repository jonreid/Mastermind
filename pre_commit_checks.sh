#!/usr/bin/env bash
set -euo pipefail

staged_files=$(git diff --cached --name-only)
[[ -z "$staged_files" ]] && echo "Nothing staged to commit" && exit 1
staged_swift=$(git diff --cached --name-only --diff-filter=d -- '*.swift' | grep -v '/ThirdParty/' || true)

./build_release.sh
if [[ -n "$staged_swift" ]]; then
    swiftlint lint --fix --force-exclude --quiet $staged_swift
    swiftformat $staged_swift
    git add -- $staged_swift
fi
if git diff --cached --quiet; then
    echo "⚠️ Nothing to commit after formatting"
    exit 1
fi
if [[ -n "$staged_swift" ]]; then
    swiftlint lint --force-exclude --quiet --strict $staged_swift
    npx jscpd -c .jscpd.json .
fi
