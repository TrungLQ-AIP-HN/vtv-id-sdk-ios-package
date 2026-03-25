// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "VtvIdSdk",
    platforms: [.iOS(.v15), .tvOS(.v16)],
    products: [
        .library(name: "VtvIdSdk", targets: ["VtvIdSdk"])
    ],
    targets: [
        .binaryTarget(
            name: "VtvIdSdk",
            path: "VtvIdSdk.xcframework.zip"
        )
    ]
)
