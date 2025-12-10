// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TwelveDataStocksAPI",
    platforms: [.macOS(.v12), .iOS(.v13), .watchOS(.v8), .tvOS(.v13)],
    products: [
        .library(
            name: "TwelveDataStocksAPI",
            targets: ["TwelveDataStocksAPI"]),
        .executable(name: "TwelveDataStocksAPIExec",
                    targets: ["TwelveDataStocksAPIExec"])
    ],
    targets: [
        .target(
            name: "TwelveDataStocksAPI",
            dependencies: []),
        .executableTarget(name: "TwelveDataStocksAPIExec",
                         dependencies: ["TwelveDataStocksAPI"])
    ]
)
