#!/bin/bash

xcodebuild test -project Mastermind.xcodeproj -scheme Mastermind -sdk iphonesimulator -destination "platform=iOS Simulator,OS=latest,name=iPhone 15"
