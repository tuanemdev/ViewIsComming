// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "ViewIsComming",
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
