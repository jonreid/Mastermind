#!/bin/bash

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=18.5,name=iPhone 16'

set -o pipefail && xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO' | xcbeautify
