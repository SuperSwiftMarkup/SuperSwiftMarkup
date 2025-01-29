// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ssm-markdown",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "SSMarkdown", targets: ["SSMarkdown"]),
        .library(name: "ssm-markdown-engine", targets: ["ssm-markdown-engine"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-markdown.git", branch: "main"),
        .package(url: "https://github.com/colbyn/SwiftPrettyTree.git", exact: "0.6.5"),
        .package(path: "../ssm-system-apis"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "ssm-foundation-utilities"),
        .target(
            name: "SSMarkdownFormat",
            dependencies: [
                "SwiftPrettyTree",
                .product(name: "Markdown", package: "swift-markdown"),
                "ssm-foundation-utilities"
            ]
        ),
        .target(
            name: "ssm-markdown-engine",
            dependencies: [
                "SSMarkdownFormat",
                "SSMUtilities",
                "ssm-system-apis",
                "ssm-foundation-utilities",
            ]
        ),
        .target(
            name: "SSMarkdownView",
            dependencies: [
                "ssm-markdown-engine",
                "SSMarkdownFormat",
                "SSMUtilities",
                "ssm-system-apis",
                "ssm-foundation-utilities",
            ]
        ),
        .target(name: "SSMUtilities"),
        .target(name: "SSDocumentAction"),
        .target(
            name: "SSMarkdown",
            dependencies: [
                "SSMarkdownFormat",
                "SSMarkdownView",
                "SSMUtilities",
            ]
        ),
//        .testTarget(name: "ssm-markdown-tests", dependencies: ["SSMarkdown"]),
    ]
)
