#!/bin/bash
# Script to build and run BabyNameGenerator in iOS Simulator

set -e

cd "/Users/user/Documents/Web development/2025/baby_name_generator"

echo "🔨 Building BabyNameGenerator..."

# Build for simulator
xcodebuild \
  -project BabyNameGenerator.xcodeproj \
  -scheme BabyNameGenerator \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -configuration Debug \
  -derivedDataPath build \
  build

echo "✅ Build complete!"
echo ""
echo "📱 Launching iPhone 15 Simulator..."

# Boot simulator if not already running
xcrun simctl boot "iPhone 15" 2>/dev/null || true

# Open Simulator app
open -a Simulator

# Install and launch the app
APP_PATH="build/Build/Products/Debug-iphonesimulator/BabyNameGenerator.app"

if [ -d "$APP_PATH" ]; then
    echo "📲 Installing app..."
    xcrun simctl install booted "$APP_PATH"

    echo "🚀 Launching app..."
    xcrun simctl launch booted com.babynames.BabyNameGenerator

    echo ""
    echo "✨ Success! The app should now be running in the simulator."
else
    echo "❌ Error: App not found at $APP_PATH"
    exit 1
fi
