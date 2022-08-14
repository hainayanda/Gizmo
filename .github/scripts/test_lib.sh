set -eo pipefail

xcodebuild -workspace Example/Gizmo.xcworkspace \
            -scheme Gizmo-Example \
            -destination platform=iOS\ Simulator,OS=15.2,name=iPhone\ 11 \
            clean test | xcpretty