#!/bin/bash

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 16'

# Prewarm to avoid "Timed out trying to boot simulator"
echo "Prewarm simulator"
open -b com.apple.iphonesimulator

echo "xcodebuild test"
set -o pipefail && xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO' | xcbeautify
