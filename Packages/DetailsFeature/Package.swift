// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DetailsFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "DetailsFeatureData", targets: [
            "DetailsFeatureData"
        ]),
        .library(name: "DetailsFeatureDomain", targets: [
            "DetailsFeatureDomain"
        ]),
        .library(name: "DetailsFeatureUI", targets: [
            "DetailsFeatureUI"
        ])
    ],
    dependencies: [
        .package(path: "../DB"),
        .package(path: "../MapsAppOpener")
    ],
    targets: [
        .target(name: "DetailsFeatureData", dependencies: [
            "DB",
            "DetailsFeatureDomain"
        ]),
        .target(name: "DetailsFeatureDomain"),
        .target(name: "DetailsFeatureUI", dependencies: [
            "DetailsFeatureDomain",
            .product(name: "MapsAppOpenerDomain", package: "MapsAppOpener")
        ]),
        .testTarget(name: "DetailsFeatureDataTests", dependencies: [
            "DB",
            "DetailsFeatureData",
            "DetailsFeatureDomain"
        ])
    ]
)
