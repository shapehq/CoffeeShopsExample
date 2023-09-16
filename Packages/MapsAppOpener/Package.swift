// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapsAppOpener",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MapsAppOpenerData", targets: [
            "MapsAppOpenerData"
        ]),
        .library(name: "MapsAppOpenerDomain", targets: [
            "MapsAppOpenerDomain"
        ])
    ],
    targets: [
        .target(name: "MapsAppOpenerData", dependencies: [
            "MapsAppOpenerDomain"
        ]),
        .target(name: "MapsAppOpenerDomain")
    ]
)
