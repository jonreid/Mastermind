#!/usr/bin/env bash
set -euo pipefail

swiftlint lint --fix --quiet
swiftformat .
git add -u
if git diff --cached --quiet; then
    echo "⚠️ Nothing to commit after formatting"
    exit 1
fi
swiftlint lint --quiet
npx jscpd .
