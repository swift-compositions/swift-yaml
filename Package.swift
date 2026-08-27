// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-yaml",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "YAML", targets: ["YAML"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-lexer.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-standards/swift-yaml-standard.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "YAML",
            dependencies: [
                .product(name: "Byte Primitive", package: "swift-byte"),
                .product(name: "Lexer", package: "swift-lexer"),
                .product(name: "YAML Standard", package: "swift-yaml-standard"),
            ],
            path: "Sources/YAML"
        ),
        .testTarget(
            name: "YAML Tests",
            dependencies: [
                .target(name: "YAML"),
                .product(name: "Byte Primitive", package: "swift-byte"),
                .product(name: "Byte Protocol", package: "swift-byte"),
            ],
            path: "Tests/YAML Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
                .enableUpcomingFeature("InferIsolatedConformances"),
        ]
}
