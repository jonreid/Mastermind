#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Error: Commit message is required."
  echo "Usage: $0 \"<commit message>\""
  exit 1
fi
set -euo pipefail
COMMIT_MESSAGE="$1"

git add .
git commit -m "$COMMIT_MESSAGE"
git push
echo "✅ Changes committed and pushed"
exit 0