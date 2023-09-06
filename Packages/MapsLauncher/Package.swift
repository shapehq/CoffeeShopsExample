// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapsLauncher",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MapsLauncherData", targets: [
            "MapsLauncherData"
        ]),
        .library(name: "MapsLauncherDomain", targets: [
            "MapsLauncherDomain"
        ])
    ],
    targets: [
        .target(name: "MapsLauncherData", dependencies: [
            "MapsLauncherDomain"
        ]),
        .target(name: "MapsLauncherDomain")
    ]
)
