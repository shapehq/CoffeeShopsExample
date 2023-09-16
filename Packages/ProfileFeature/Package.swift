// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProfileFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "ProfileFeatureData", targets: [
            "ProfileFeatureData"
        ]),
        .library(name: "ProfileFeatureDomain", targets: [
            "ProfileFeatureDomain"
        ]),
        .library(name: "ProfileFeatureUI", targets: [
            "ProfileFeatureUI"
        ])
    ],
    dependencies: [
        .package(path: "../AnyAsync"),
        .package(path: "../Authentication"),
        .package(path: "../DB"),
        .package(path: "../MapsAppOpener")
    ],
    targets: [
        .target(name: "ProfileFeatureData", dependencies: [
            "AnyAsync",
            "DB",
            "ProfileFeatureDomain"
        ]),
        .target(name: "ProfileFeatureDomain", dependencies: [
            "AnyAsync"
        ]),
        .target(name: "ProfileFeatureUI", dependencies: [
            "AnyAsync",
            .product(name: "AuthenticationDomain", package: "Authentication"),
            .product(name: "MapsAppOpenerDomain", package: "MapsAppOpener"),
            "ProfileFeatureDomain"
        ], resources: [
            .process("Assets.xcassets")
        ]),
        .testTarget(name: "ProfileFeatureDataTests", dependencies: [
            "AnyAsync",
            "DB",
            "ProfileFeatureData"
        ])
    ]
)
