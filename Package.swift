// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFastPFOR",
    platforms: [.macOS(.v13),.visionOS(.v1),.iOS(.v16),.tvOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftFastPFOR",
            targets: ["SwiftFastPFOR"]),
    ],
    dependencies: [
      .package(
        url: "https://github.com/bastie/JavApi4Swift.git",
        .upToNextMajor(from: "0.8.1")
      )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftFastPFOR",
            dependencies: [
              .product(name: "JavApi", package: "JavApi4Swift")
            ],
            swiftSettings: [
              .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "SwiftFastPFORTests",
            dependencies: ["SwiftFastPFOR",
                           .product(name: "JavApi", package: "JavApi4Swift")
            ],
        resources: [.process("Resources")]
        ),
    ]
)
