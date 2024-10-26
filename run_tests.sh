#!/bin/bash

SCHEME='Mastermind'
DESTINATION='platform=iOS Simulator,OS=latest,name=iPhone 16'

xcodebuild test -scheme $SCHEME -sdk iphonesimulator -destination "$DESTINATION" -disableAutomaticPackageResolution CODE_SIGNING_ALLOWED='NO'
