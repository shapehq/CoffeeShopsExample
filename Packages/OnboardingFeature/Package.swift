// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OnboardingFeature",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "OnboardingFeatureUI", targets: [
            "OnboardingFeatureUI"
        ])
    ],
    dependencies: [
        .package(path: "../Authentication")
    ],
    targets: [
        .target(name: "OnboardingFeatureUI", dependencies: [
            .product(name: "AuthenticationDomain", package: "Authentication")
        ], resources: [
            .process("Assets.xcassets")
        ])
    ]
)
