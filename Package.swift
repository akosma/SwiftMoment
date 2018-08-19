// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMoment",
    products: [
        .library(name: "SwiftMoment", targets: ["SwiftMoment"]),
    ],
    dependencies: [
        // none
    ],
    targets: [
        .target(name: "SwiftMoment", path: ".", sources: ["SwiftMoment/SwiftMoment"]),
        .testTarget(name: "SwiftMomentTests", dependencies: ["SwiftMoment"], path: ".", sources: ["SwiftMoment/SwiftMomentTests"]),
    ]
)
