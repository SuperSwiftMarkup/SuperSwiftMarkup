// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ssm-typesetter-engine",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "typesetter-engine", targets: ["typesetter-engine"]),
    ],
    dependencies: [
        .package(path: "../ssm-system-apis"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "type-engine-actions"),
        .target(
            name: "type-engine-document-model",
            dependencies: [
                "ssm-system-apis"
            ]
        ),
        .target(
            name: "type-engine-ui",
            dependencies: [
                "ssm-system-apis",
                "type-engine-actions",
                "type-engine-document-model",
            ]
        ),
        .target(
            name: "typesetter-engine",
            dependencies: [
                "type-engine-actions",
                "type-engine-document-model",
                "type-engine-ui",
            ]
        )
//        .testTarget(name: "typesetter-engine-ui-tests", dependencies: ["typesetter-engine-ui"]),
    ]
)
