// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ViewIsComming",
    platforms: [.iOS(.v17), .visionOS(.v2), .macOS(.v14), .watchOS(.v10)],
    products: [
        .library(
            name: "ViewIsComming",
            targets: ["ViewIsComming"],
        ),
    ],
    targets: [
        .target(
            name: "ViewIsComming",
            swiftSettings: [
                .defaultIsolation(MainActor.self),
            ],
        ),
    ],
)
