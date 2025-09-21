#!/bin/bash

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=18.5,name=iPhone 16'

if grep -R -n --include='*Tests.swift' -E '^\s*// (Arrange|Act|Assert|Given|When|Then)\b' . ; then
  echo "Error: Forbidden test comments detected. Remove these comments from tests."
  exit 1
fi

set -o pipefail && xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO' | xcbeautify
