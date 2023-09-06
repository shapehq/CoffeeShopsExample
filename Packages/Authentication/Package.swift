// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "AuthenticationData", targets: [
            "AuthenticationData"
        ]),
        .library(name: "AuthenticationDomain", targets: [
            "AuthenticationDomain"
        ])
    ],
    targets: [
        .target(name: "AuthenticationData", dependencies: [
            "AuthenticationDomain"
        ]),
        .target(name: "AuthenticationDomain"),
        .testTarget(name: "AuthenticationDataTests", dependencies: [
            "AuthenticationData",
            "AuthenticationDomain"
        ])
    ]
)
