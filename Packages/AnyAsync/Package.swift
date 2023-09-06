// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnyAsync",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "AnyAsync", targets: [
            "AnyAsync"
        ])
    ],
    targets: [
        .target(name: "AnyAsync"),
        .testTarget(name: "AnyAsyncTests", dependencies: [
            "AnyAsync"
        ])
    ]
)
