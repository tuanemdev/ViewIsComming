// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ViewIsComming",
    platforms: [
        .iOS(.v17),
        .visionOS(.v2),
        .macOS(.v14),
        .macCatalyst(.v17),
        .watchOS(.v10),
        .tvOS(.v17),
    ],
    products: [
        .library(
            name: "ViewIsComming",
            targets: ["ViewIsComming"],
        ),
    ],
    targets: [
        .target(
            name: "ViewIsComming",
        ),
    ],
)
