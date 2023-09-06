// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DB",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "DB", targets: [
            "DB"
        ]),
        .library(name: "SwiftDataDB", targets: [
            "SwiftDataDB"
        ])
    ],
    dependencies: [
        .package(path: "../AnyAsync")
    ],
    targets: [
        .target(name: "DB", dependencies: [
            "AnyAsync"
        ]),
        .target(name: "SwiftDataDB", dependencies: [
            "AnyAsync",
            "DB"
        ]),
        .testTarget(name: "SwiftDataDBTests", dependencies: [
            "SwiftDataDB"
        ])
    ]
)
