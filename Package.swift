// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "mac-reminder-cli",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0")
    ],
    targets: [
        .executableTarget(
            name: "rem",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            path: "Sources/rem"
        ),
        .testTarget(
            name: "remTests",
            dependencies: ["rem"],
            path: "Tests/remTests"
        ),
    ]
)
