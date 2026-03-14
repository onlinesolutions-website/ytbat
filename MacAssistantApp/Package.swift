// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "MacAssistantApp",
    products: [
        .library(name: "MacAssistantApp", targets: ["MacAssistantApp"])
    ],
    targets: [
        .target(name: "MacAssistantApp"),
        .testTarget(name: "MacAssistantAppTests", dependencies: ["MacAssistantApp"])
    ]
)
