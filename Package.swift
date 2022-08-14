// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Gizmo",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "Gizmo",
            targets: ["Gizmo"]
        )
    ],
    dependencies: [
        // uncomment code below to test
       .package(name: "Fakery", url: "https://github.com/vadymmarkov/Fakery", from: "5.1.0"))
       .package(url: "https://github.com/Quick/Quick.git", from: "5.0.1"),
       .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "Gizmo",
            dependencies: [],
            path: "Gizmo/Classes"
        ),
        // uncomment code below to test
       .testTarget(
           name: "GizmoTests",
           dependencies: [
               "Gizmo", "Quick", "Nimble", "Fakery"
           ],
           path: "Example/Tests",
           exclude: ["Info.plist"]
       )
    ]
)
