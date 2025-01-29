// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSMarkdownFormat",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "SSMarkdownFormat", targets: ["SSMarkdownFormat"]),
    ],
    dependencies: [
        .package(path: "../SSMUtilities"),
        .package(url: "https://github.com/swiftlang/swift-markdown.git", branch: "main"),
        .package(url: "https://github.com/colbyn/SwiftPrettyTree.git", exact: "0.6.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SSMarkdownFormat",
            dependencies: [
                "SSMUtilities",
                "SwiftPrettyTree",
                .product(name: "Markdown", package: "swift-markdown"),
            ]
        ),
        .testTarget(name: "SSMarkdownFormatTests", dependencies: ["SSMarkdownFormat"]),
    ]
)
