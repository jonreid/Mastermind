#!/usr/bin/env bash
set -euo pipefail

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=26.4.1,name=iPhone 17'

xcodebuild -configuration Release -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO' | xcbeautify
