// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "MastermindCore",
    products: [
        .library(
            name: "MastermindCore",
            targets: ["MastermindCore"],
        ),
    ],
    targets: [
        .target(
            name: "MastermindCore",
        ),
        .testTarget(
            name: "MastermindCoreTests",
            dependencies: ["MastermindCore"],
        ),
    ],
    swiftLanguageModes: [.v6],
)
