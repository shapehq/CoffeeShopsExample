// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MapFeatureData", targets: [
            "MapFeatureData"
        ]),
        .library(name: "MapFeatureDomain", targets: [
            "MapFeatureDomain"
        ]),
        .library(name: "MapFeatureUI", targets: [
            "MapFeatureUI"
        ])
    ],
    dependencies: [
        .package(path: "../DB")
    ],
    targets: [
        .target(name: "MapFeatureData", dependencies: [
            "DB",
            "MapFeatureDomain"
        ]),
        .target(name: "MapFeatureDomain"),
        .target(name: "MapFeatureUI", dependencies: [
            "MapFeatureDomain"
        ])
    ]
)
