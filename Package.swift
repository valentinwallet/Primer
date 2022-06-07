// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Primer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Primer",
            targets: ["Primer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/auth0/JWTDecode.swift.git", .upToNextMajor(from: "2.6.3"))
    ],
    targets: [
        .target(
            name: "Primer",
            dependencies: [
                .product(name: "JWTDecode", package: "JWTDecode.swift")
            ]),
        .testTarget(
            name: "PrimerTests",
            dependencies: ["Primer"]),
    ],
    swiftLanguageVersions: [.v5]
)
